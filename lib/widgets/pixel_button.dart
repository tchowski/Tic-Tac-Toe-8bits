import 'package:flutter/material.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_colors.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';

class PixelButton extends StatelessWidget {
  const PixelButton({super.key, required this.onPressed, required this.child, this.padding});

  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding:
            padding ??
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingXL, vertical: AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          border: Border.all(color: AppColors.primary, width: 2),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), offset: const Offset(0, 4), blurRadius: 8),
          ],
        ),
        child: child,
      ),
    );
  }
}
