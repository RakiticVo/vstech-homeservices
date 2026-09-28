import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_assets.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/customer_floating_dock.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/home_devices_card.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/home_top_header.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/service_category_tile.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/service_offer_card.dart';

/// Screen 09 — Customer Home Screen.
/// The primary entry point for Customer role.
/// Features top greeting, search bar, hero banner, 8 services grid, special offers,
/// home devices status, and a fixed floating bottom dock with 128px scroll clearance.
class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int _currentDockTab = 0;

  void _onCategoryTapped(String serviceId) {
    unawaited(context.push('${AppRoutes.serviceDetail}?id=$serviceId'));
  }

  void _onNavigateToCategories() {
    unawaited(context.push(AppRoutes.categories));
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      _CategoryData(
        id: 'clean',
        title: context.l10n.svcCleanTitle,
        iconAsset: AppAssets.svcClean,
      ),
      _CategoryData(
        id: 'plumb',
        title: context.l10n.svcPlumbTitle,
        iconAsset: AppAssets.svcPlumb,
      ),
      _CategoryData(
        id: 'ac',
        title: context.l10n.svcAcTitle,
        iconAsset: AppAssets.svcAc,
      ),
      _CategoryData(
        id: 'laundry',
        title: context.l10n.svcLaundryTitle,
        iconAsset: AppAssets.svcLaundry,
      ),
      _CategoryData(
        id: 'maid',
        title: context.l10n.svcMaidTitle,
        iconAsset: AppAssets.svcMaid,
      ),
      _CategoryData(
        id: 'pest',
        title: context.l10n.svcPestTitle,
        iconAsset: AppAssets.svcPest,
      ),
      _CategoryData(
        id: 'install',
        title: context.l10n.svcInstallTitle,
        iconAsset: AppAssets.svcInstall,
      ),
      _CategoryData(
        id: 'appliance',
        title: context.l10n.svcApplianceTitle,
        iconAsset: AppAssets.svcAppliance,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Scrollable main content with mandatory 128px dock clearance
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.dockClearanceMax,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Greeting Header
                  const HomeTopHeader(),

                  const SizedBox(height: AppSpacing.lg),

                  // Search Bar
                  InkWell(
                    onTap: _onNavigateToCategories,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 20, color: AppColors.textMuted),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              context.l10n.homeSearchPlaceholder,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyMd.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Hero Banner
                  InkWell(
                    onTap: _onNavigateToCategories,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      child: Container(
                        height: 159,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Image.asset(
                          AppAssets.heroBanner,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: AppColors.secondarySurface,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.home_repair_service,
                              size: 48,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Section 1: Essential Services (8 categories in 3-column grid)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.homeSectionCategories,
                        style: AppTextStyles.headlineMd.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: _onNavigateToCategories,
                        child: Text(
                          context.l10n.homeSectionSeeAll,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // 3-column Grid for 8 service items
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: AppSpacing.sm,
                      crossAxisSpacing: AppSpacing.sm,
                      childAspectRatio: 0.82,
                    ),
                    itemBuilder: (context, index) {
                      final item = categories[index];
                      return ServiceCategoryTile(
                        title: item.title,
                        iconAsset: item.iconAsset,
                        onTap: () => _onCategoryTapped(item.id),
                      );
                    },
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Section 2: Special Offers
                  Text(
                    context.l10n.homeSectionOffers,
                    style: AppTextStyles.headlineMd.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Horizontal Offers List
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ServiceOfferCard(
                          title: context.l10n.svcAcTitle.replaceAll('\n', ' '),
                          description: context.l10n.acServiceDesc,
                          priceText: context.l10n.startingFrom('150.000đ'),
                          tagText: context.l10n.offerTag15,
                          speedText: context.l10n.offerTagFast,
                          ratingText: '4.9 ★',
                          iconAsset: AppAssets.svcAc,
                          onTap: () => _onCategoryTapped('ac'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        ServiceOfferCard(
                          title: context.l10n.svcCleanTitle.replaceAll('\n', ' '),
                          description: context.l10n.cleanServiceDesc,
                          priceText: context.l10n.startingFrom('120.000đ'),
                          tagText: context.l10n.offerTag15,
                          speedText: context.l10n.offerTagFast,
                          ratingText: '4.8 ★',
                          iconAsset: AppAssets.svcClean,
                          onTap: () => _onCategoryTapped('clean'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        ServiceOfferCard(
                          title: context.l10n.svcPlumbTitle.replaceAll('\n', ' '),
                          description: context.l10n.plumbServiceDesc,
                          priceText: context.l10n.startingFrom('180.000đ'),
                          tagText: context.l10n.offerTag15,
                          speedText: context.l10n.offerTagFast,
                          ratingText: '4.9 ★',
                          iconAsset: AppAssets.svcPlumb,
                          onTap: () => _onCategoryTapped('plumb'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Section 3: Your Home & Devices Health Card
                  const HomeDevicesCard(),
                ],
              ),
            ),

            // Fixed Floating Navigation Dock at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomerFloatingDock(
                currentIndex: _currentDockTab,
                onTabSelected: (index) {
                  setState(() => _currentDockTab = index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryData {
  const _CategoryData({
    required this.id,
    required this.title,
    required this.iconAsset,
  });

  final String id;
  final String title;
  final String iconAsset;
}
