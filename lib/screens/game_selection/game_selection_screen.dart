import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/generated/l10n.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_assets.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_colors.dart';

import 'package:auto_route/auto_route.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/core/router/app_router.gr.dart';
import 'package:tic_tac_toc_8_bits/screens/game_selection/cubit/game_selection_screen_cubit.dart';
import 'package:tic_tac_toc_8_bits/widgets/pixel_button.dart';
import 'package:tic_tac_toc_8_bits/widgets/background_tiles.dart';

@RoutePage()
class GameSelectionScreen extends StatelessWidget implements AutoRouteWrapper {
  const GameSelectionScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => GameSelectionScreenCubit(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return Scaffold(
      body: BackgroundTiles(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Title(title: l10n.game_selection_title_player_select),
            SizedBox(height: AppDimensions.compactSpacing),
            _ButtonSelection(
              value: GameSelectionScreenMode.onePlayer,
              title: l10n.game_selection_mode_one_player,
              onPressed: () {
                context.read<GameSelectionScreenCubit>().setMode(GameSelectionScreenMode.onePlayer);
              },
            ),
            _ButtonSelection(
              value: GameSelectionScreenMode.twoPlayer,
              title: l10n.game_selection_mode_two_player,
              onPressed: () {
                context.read<GameSelectionScreenCubit>().setMode(GameSelectionScreenMode.twoPlayer);
              },
            ),
            SizedBox(height: AppDimensions.mediumSpacing),
            if (context.select(
              (GameSelectionScreenCubit cubit) => cubit.state.mode == GameSelectionScreenMode.onePlayer,
            )) ...[
              _Title(title: l10n.game_selection_title_difficulty),
              SizedBox(height: AppDimensions.compactSpacing),
              _ButtonSelection(
                value: GameSelectionScreenDifficulty.easy,
                title: l10n.game_selection_difficulty_easy,
                onPressed: () {
                  context.read<GameSelectionScreenCubit>().setDifficulty(GameSelectionScreenDifficulty.easy);
                },
              ),
              _ButtonSelection(
                value: GameSelectionScreenDifficulty.medium,
                title: l10n.game_selection_difficulty_medium,
                onPressed: () {
                  context.read<GameSelectionScreenCubit>().setDifficulty(GameSelectionScreenDifficulty.medium);
                },
              ),
              _ButtonSelection(
                value: GameSelectionScreenDifficulty.hard,
                title: l10n.game_selection_difficulty_hard,
                onPressed: () {
                  context.read<GameSelectionScreenCubit>().setDifficulty(GameSelectionScreenDifficulty.hard);
                },
              ),
            ],
            SizedBox(height: AppDimensions.paddingXL),
            BlocBuilder<GameSelectionScreenCubit, GameSelectionScreenState>(
              builder: (context, state) {
                return PixelButton(
                  onPressed: () {
                    context.router.push(GameRoute(mode: state.mode, difficulty: state.difficulty));
                  },
                  child: Text(
                    l10n.game_selection_action_start,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonSelection<T> extends StatelessWidget {
  const _ButtonSelection({required this.title, required this.onPressed, required this.value});
  final String title;
  final VoidCallback onPressed;
  final T value;

  @override
  Widget build(BuildContext context) {
    final isSelected =
        value == context.select((GameSelectionScreenCubit cubit) => cubit.state.mode) ||
        value == context.select((GameSelectionScreenCubit cubit) => cubit.state.difficulty);
    return Padding(
      padding: isSelected ? const EdgeInsets.only(right: AppDimensions.iconS) : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isSelected)
            Image.asset(AppAssets.playerIndicatorArrow, width: AppDimensions.iconS, height: AppDimensions.iconS),
          SizedBox(width: AppDimensions.compactSpacing),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.textSelectGameButton),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
    );
  }
}
