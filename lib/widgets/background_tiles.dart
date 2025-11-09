import 'dart:math' show max;

import 'package:flutter/material.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_assets.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/screens/game/widgets/game_home_button.dart';
import 'package:tic_tac_toc_8_bits/widgets/music_toggle_button.dart';

class BackgroundTiles extends StatelessWidget {
  final Widget child;
  final String backgroundImage;
  final bool showHomeButton;
  const BackgroundTiles({
    super.key,
    required this.child,
    this.backgroundImage = AppAssets.backgroundTileBlue,
    this.showHomeButton = false,
  });

  @override
  Widget build(BuildContext context) {
    const borderThickness = 24.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final innerWidth = max(0.0, constraints.maxWidth - borderThickness * 2);
        final innerHeight = max(0.0, constraints.maxHeight - borderThickness * 2);

        return Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(backgroundImage), repeat: ImageRepeat.repeat),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.borderFullScreenBomber),
                    fit: BoxFit.fill,
                    centerSlice: Rect.fromLTWH(24, 24, 208, 208),
                  ),
                ),
              ),
            ),
            Align(
              child: SizedBox(
                width: innerWidth,
                height: innerHeight,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: AppDimensions.paddingS,
                      right: AppDimensions.paddingS,
                      child: MusicToggleButton(),
                    ),
                    if (showHomeButton)
                      Positioned(bottom: AppDimensions.paddingS, left: AppDimensions.paddingS, child: GameHomeButton()),
                    Center(child: child),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
