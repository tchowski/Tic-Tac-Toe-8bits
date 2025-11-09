import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_colors.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/core/router/app_router.gr.dart';

class GameHomeButton extends StatelessWidget {
  const GameHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.pushAndPopUntil(StartRoute(), predicate: (route) => route.isFirst);
      },
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingS),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.home, color: AppColors.primary, size: AppDimensions.iconM)],
        ),
      ),
    );
  }
}
