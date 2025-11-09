import 'package:flutter/material.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_colors.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/screens/game/logic/cubit/game_state.dart';
import 'package:tic_tac_toc_8_bits/screens/game_selection/cubit/game_selection_screen_cubit.dart';
import 'package:i18n/generated/l10n.dart';

class GameStatusLabel extends StatelessWidget {
  const GameStatusLabel({super.key, required this.state, required this.mode, required this.isAiTurn});

  final GameBoardState state;
  final GameSelectionScreenMode mode;
  final bool isAiTurn;

  @override
  Widget build(BuildContext context) {
    final statusLabel = _statusLabel(context);
    final statusColor = _statusColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical: AppDimensions.paddingS),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Text(
        statusLabel,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: statusColor, letterSpacing: 2),
      ),
    );
  }

  String _statusLabel(BuildContext context) {
    final l10n = I18n.of(context);

    if (state.winner != null) {
      return state.winner == GamePlayer.cross ? l10n.game_status_player1_wins : l10n.game_status_player2_wins;
    }

    if (state.isDraw) {
      return l10n.game_status_draw;
    }

    if (isAiTurn) {
      return l10n.game_status_ai_turn;
    }

    return state.currentPlayer == GamePlayer.cross ? l10n.game_status_player1_turn : l10n.game_status_player2_turn;
  }

  Color _statusColor() {
    if (state.winner != null) {
      return AppColors.primary;
    }
    if (state.isDraw) {
      return AppColors.secondary;
    }
    return AppColors.textPrimary;
  }
}
