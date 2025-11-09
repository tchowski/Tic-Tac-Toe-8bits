import 'package:flutter/material.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_state.dart';
import 'package:tic_tac_toc_8_bits/screens/game/widgets/game_cell.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    super.key,
    required this.board,
    required this.isLocked,
    required this.onCellTap,
  });

  final List<GamePiece> board;
  final bool Function(int index) isLocked;
  final void Function(int index) onCellTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingXL),
      child: Center(
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppDimensions.paddingXXS,
            crossAxisSpacing: AppDimensions.paddingXXS,
            childAspectRatio: 0.75,
          ),
          itemCount: board.length,
          itemBuilder: (context, index) {
            return GameCell(
              index: index,
              piece: board[index],
              isLocked: isLocked(index),
              onTap: () => onCellTap(index),
            );
          },
        ),
      ),
    );
  }
}

