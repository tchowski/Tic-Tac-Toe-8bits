import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:i18n/generated/l10n.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_assets.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_colors.dart';
import 'package:tic_tac_toc_8_bits/core/constants/app_dimensions.dart';
import 'package:tic_tac_toc_8_bits/core/di/injection.dart';
import 'package:tic_tac_toc_8_bits/core/managers/audio_manager.dart';
import 'package:tic_tac_toc_8_bits/core/router/app_router.gr.dart';
import 'package:tic_tac_toc_8_bits/widgets/background_tiles.dart';

@RoutePage()
class StartScreen extends StatefulWidget {
  StartScreen({super.key, AudioManager? audioManager}) : audioManager = audioManager ?? getIt<AudioManager>();
  final AudioManager audioManager;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this)..repeat(reverse: true);
    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _initializeMusic();
  }

  Future<void> _initializeMusic() async {
    if (widget.audioManager.isInitialized) return;
    await widget.audioManager.initialize();
    await widget.audioManager.playMusic(AppAssets.audioTheme);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () => context.router.push(const GameSelectionRoute()),
        child: BackgroundTiles(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.logo),
              const SizedBox(height: AppDimensions.paddingL),
              FadeTransition(
                opacity: _opacityAnimation,
                child: Text(
                  l10n.splash_screen_press_start,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(color: AppColors.primary, letterSpacing: 4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
