import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_assets.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen 01 — Splash Screen.
/// Displays the full brand illustration with a smooth loading progress bar.
/// Navigates automatically to Onboarding after 2.5 seconds or immediately upon tap.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    _navigationTimer = Timer(const Duration(milliseconds: 2500), _navigateToNext);
  }

  void _navigateToNext() {
    if (!mounted) return;
    _navigationTimer?.cancel();
    context.go(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: _navigateToNext,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Splash Brand Illustration
            Image.asset(
              AppAssets.splashFull,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (_, _, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.home_work_outlined,
                      size: 72,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'HomeService',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom loading bar
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 130,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                  child: AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, _) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _progressController.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadius.chip),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
