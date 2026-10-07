import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_assets.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/splash_cubit.dart';

/// Screen 01 — Splash Screen.
/// Displays the full brand illustration with a smooth loading progress bar.
/// While the brand animation plays, [SplashCubit] resolves the session; the page then opens
/// onboarding (signed out) or the role's home — never before the animation's minimum duration.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;
  Timer? _minDurationTimer;
  bool _minDurationElapsed = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))..forward();

    _minDurationTimer = Timer(const Duration(milliseconds: 2500), () {
      _minDurationElapsed = true;
      _navigateIfResolved();
    });
    unawaited(context.read<SplashCubit>().resolve());
  }

  /// Tapping skips the remaining animation once the destination is known.
  void _skipAnimation() {
    _minDurationTimer?.cancel();
    _minDurationElapsed = true;
    _navigateIfResolved();
  }

  void _navigateIfResolved() {
    if (!mounted || !_minDurationElapsed) return;
    final state = context.read<SplashCubit>().state;
    if (state is! SplashResolvedState) return;
    context.go(switch (state.destination) {
      SplashDestination.onboarding => AppRoutes.onboarding,
      SplashDestination.customerHome => AppRoutes.customerHome,
      SplashDestination.workerHome => AppRoutes.workerDashboard,
    });
  }

  @override
  void dispose() {
    _minDurationTimer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) => _navigateIfResolved(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: GestureDetector(
          onTap: _skipAnimation,
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
                      const Icon(Icons.home_work_outlined, size: 72, color: AppColors.primary),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'HomeService',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              // Session could not be resolved (offline / server error): message + retry.
              BlocBuilder<SplashCubit, SplashState>(
                builder: (context, state) => switch (state) {
                  SplashErrorState(:final failure) => Positioned(
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    bottom: 96,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.l10n.failureMessage(failure),
                            key: const Key('splash_error_message'),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppButton.primary(
                            key: const Key('splash_retry_button'),
                            label: context.l10n.retry,
                            icon: Icons.refresh,
                            onPressed: () => unawaited(context.read<SplashCubit>().resolve()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _ => const SizedBox.shrink(),
                },
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
      ),
    );
  }
}
