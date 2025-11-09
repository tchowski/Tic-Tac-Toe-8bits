import 'package:flutter/material.dart';
import 'package:i18n/generated/l10n.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_colors.dart';
import 'package:tic_tac_toc_8_bits/widgets/pixel_button.dart';

class GameRestartButton extends StatelessWidget {
  const GameRestartButton({super.key, required this.onRestart});

  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return PixelButton(
      onPressed: onRestart,
      child: Text(
        I18n.of(context).game_action_restart,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold, letterSpacing: 3),
      ),
    );
  }
}
