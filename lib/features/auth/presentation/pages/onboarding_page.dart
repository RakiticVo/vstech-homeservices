import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_assets.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/dots_indicator_widget.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/language_toggle_button.dart';

/// Screen 02 — Onboarding Screen.
/// 4 sequential slides presenting service value with culturally rich Vietnamese illustrations.
/// Features 2-way dot indicator jumping, skip-to-role action, and smooth slide navigation.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSkip() {
    context.go(AppRoutes.roleGateway);
  }

  void _onNext() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(AppRoutes.intro);
    }
  }

  void _onDotTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final slides = [
      _SlideData(
        imageAsset: AppAssets.ob1Clean,
        title: context.l10n.ob1Title,
        description: context.l10n.ob1Desc,
      ),
      _SlideData(
        imageAsset: AppAssets.ob2Tech,
        title: context.l10n.ob2Title,
        description: context.l10n.ob2Desc,
      ),
      _SlideData(
        imageAsset: AppAssets.ob3Steps,
        title: context.l10n.ob3Title,
        description: context.l10n.ob3Desc,
      ),
      _SlideData(
        imageAsset: AppAssets.ob4Ai,
        title: context.l10n.ob4Title,
        description: context.l10n.ob4Desc,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top action bar (Language switch + Skip shortcut)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LanguageToggleButton(),
                  TextButton(
                    onPressed: _onSkip,
                    child: Text(
                      context.l10n.skip,
                      style: AppTextStyles.labelMd.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Slide PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemBuilder: (context, index) {
                  final item = slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.sm),
                        // Title
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.headlineMd.copyWith(
                            fontSize: 24,
                            height: 1.25,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),

                        // Image container
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                            child: Image.asset(
                              item.imageAsset,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        // Description
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dots indicator
            DotsIndicatorWidget(
              itemCount: slides.length,
              currentIndex: _currentPage,
              onDotTapped: _onDotTapped,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Bottom Buttons Row
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  // Skip button (mint container)
                  Expanded(
                    flex: 2,
                    child: AppSecondaryButton(
                      label: context.l10n.skip,
                      backgroundColor: AppColors.secondarySurface,
                      borderColor: AppColors.border,
                      textColor: AppColors.textPrimary,
                      onPressed: _onSkip,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Next button (primary teal)
                  Expanded(
                    flex: 3,
                    child: AppButton(
                      label: context.l10n.next,
                      icon: Icons.arrow_forward,
                      onPressed: _onNext,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideData {
  const _SlideData({
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  final String imageAsset;
  final String title;
  final String description;
}
