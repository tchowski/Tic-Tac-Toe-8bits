import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_assets.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_state.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_cubit.dart';
import 'package:tic_tac_toc_8_bits/screens/game_selection/cubit/game_selection_screen_cubit.dart';
import 'package:tic_tac_toc_8_bits/screens/game/widgets/game_board.dart';
import 'package:tic_tac_toc_8_bits/screens/game/widgets/game_restart_button.dart';
import 'package:tic_tac_toc_8_bits/screens/game/widgets/game_status_label.dart';
import 'package:tic_tac_toc_8_bits/widgets/background_tiles.dart';

@RoutePage()
class GameScreen extends StatelessWidget implements AutoRouteWrapper {
  const GameScreen({
    super.key,
    this.mode = GameSelectionScreenMode.twoPlayer,
    this.difficulty = GameSelectionScreenDifficulty.easy,
  });

  final GameSelectionScreenMode mode;
  final GameSelectionScreenDifficulty difficulty;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<GameCubit>(create: (context) => GameCubit(mode, difficulty), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTiles(
        backgroundImage: AppAssets.backgroundTileSand,
        showHomeButton: true,
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            if (state is! GameBoardState) {
              return const Center(child: CircularProgressIndicator());
            }

            final showRestart = state.winner != null || state.isDraw;
            final isAiTurn =
                mode == GameSelectionScreenMode.onePlayer && !showRestart && state.currentPlayer == GamePlayer.circle;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GameStatusLabel(state: state, mode: mode, isAiTurn: isAiTurn),
                  GameBoard(
                    board: state.board,
                    isLocked: (index) {
                      final piece = state.board[index];
                      return piece != GamePiece.none || showRestart || isAiTurn;
                    },
                    onCellTap: (index) => _onCellTap(context, index),
                  ),
                  if (showRestart) GameRestartButton(onRestart: () => _onRestart(context)) else const SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onCellTap(BuildContext context, int index) {
    context.read<GameCubit>().playAt(index);
  }

  void _onRestart(BuildContext context) {
    context.read<GameCubit>().reset();
  }
}
