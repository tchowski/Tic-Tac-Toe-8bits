import 'package:flutter/material.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_colors.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/core/managers/audio_manager.dart';
import 'package:tic_tac_toc_8_bits/core/di/injection.dart';

class MusicToggleButton extends StatefulWidget {
  MusicToggleButton({super.key, AudioManager? audioManager}) : audioManager = audioManager ?? getIt<AudioManager>();
  final AudioManager audioManager;

  @override
  State<MusicToggleButton> createState() => _MusicToggleButtonState();
}

class _MusicToggleButtonState extends State<MusicToggleButton> {
  void _toggleMusic() {
    setState(() {
      widget.audioManager.toggleMusic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleMusic,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingS),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Icon(
          widget.audioManager.isMusicEnabled ? Icons.music_note : Icons.music_off,
          color: AppColors.primary,
          size: AppDimensions.iconM,
        ),
      ),
    );
  }
}
