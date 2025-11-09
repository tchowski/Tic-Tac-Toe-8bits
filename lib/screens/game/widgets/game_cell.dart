import 'package:flutter/material.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_colors.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_state.dart';
import 'package:tic_tac_toc_8_bits/screens/game/widgets/game_piece_sprite.dart';

class GameCell extends StatelessWidget {
  const GameCell({super.key, required this.index, required this.piece, required this.isLocked, required this.onTap});

  final int index;
  final GamePiece piece;
  final bool isLocked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: AppColors.surface.withOpacity(0.7),
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
        ),
        child: Center(child: GamePieceSprite(key: ValueKey(piece), piece: piece)),
      ),
    );
  }
}
