import 'package:flutter/material.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_assets.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_state.dart';

class GamePieceSprite extends StatelessWidget {
  const GamePieceSprite({required this.piece, super.key});

  final GamePiece piece;

  @override
  Widget build(BuildContext context) {
    if (piece == GamePiece.cross) {
      return Image.asset(
        AppAssets.tileXRed,
        fit: BoxFit.cover,
        width: AppDimensions.iconXL,
        height: AppDimensions.iconXL,
      );
    }
    if (piece == GamePiece.circle) {
      return Image.asset(
        AppAssets.tileOBlue,
        fit: BoxFit.cover,
        width: AppDimensions.iconXL,
        height: AppDimensions.iconXL,
      );
    }
    return const SizedBox.shrink();
  }
}
