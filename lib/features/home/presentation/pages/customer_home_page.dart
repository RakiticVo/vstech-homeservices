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
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/profile_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/categories_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/customer_floating_dock.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/home_devices_card.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/home_top_header.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/service_category_tile.dart';

/// Screen 09 — Customer Home Screen.
/// The primary entry point for Customer role.
/// Features top greeting, search bar, hero banner, 8 services grid (`GET /service-categories`),
/// home devices status, and a fixed floating bottom dock with 128px scroll clearance.
class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  void _onCategoryTapped(String serviceId) {
    unawaited(context.push('${AppRoutes.serviceDetail}?id=$serviceId'));
  }

  /// Vietnamese names end with the given name: "Nguyễn Thị Mai" → "Mai".
  static String _firstName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? '' : parts.last;
  }

  void _onNavigateToCategories() {
    unawaited(context.push(AppRoutes.categories));
  }

  @override
  Widget build(BuildContext context) {
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
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      final profile = state.profile;
                      final address = profile?.defaultAddress;
                      return HomeTopHeader(
                        userName: _firstName(profile?.fullName ?? ''),
                        address: address == null || address.isEmpty
                            ? null
                            : address,
                        onAddressTap: () =>
                            unawaited(context.push(AppRoutes.editAddress)),
                        onNotificationTap: () => unawaited(
                          context.push(AppRoutes.customerNotifications),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Search Bar
                  InkWell(
                    onTap: _onNavigateToCategories,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            size: 20,
                            color: AppColors.textMuted,
                          ),
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

                  // Up to 8 categories from GET /service-categories in a 4-column grid
                  BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) => switch (state) {
                      CategoriesErrorState(:final failure) => ErrorRetryView(
                        message: context.l10n.failureMessage(failure),
                        onRetry: () =>
                            unawaited(context.read<CategoriesCubit>().load()),
                      ),
                      CategoriesLoadedState(:final categories)
                          when categories.isEmpty =>
                        Text(
                          context.l10n.categoriesEmpty,
                          style: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      CategoriesLoadedState(:final categories) => _CategoryGrid(
                        itemCount: categories.length.clamp(
                          0,
                          _homeCategoryCount,
                        ),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return ServiceCategoryTile(
                            title: category.name,
                            imageUrl: category.imageUrl,
                            onTap: () => _onCategoryTapped(category.id),
                          );
                        },
                      ),
                      CategoriesInitialState() ||
                      CategoriesLoadingState() => _CategoryGrid(
                        itemCount: _homeCategoryCount,
                        itemBuilder: (_, _) => const _CategoryTilePlaceholder(),
                      ),
                    },
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Section 3: Your Home & Devices Health Card
                  const HomeDevicesCard(),
                ],
              ),
            ),

            // Fixed Floating Navigation Dock at bottom
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomerFloatingDock(currentIndex: 0),
            ),
          ],
        ),
      ),
    );
  }
}

/// Number of categories shown on Home; the full list is on the Categories screen.
const int _homeCategoryCount = 8;

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.itemCount, required this.itemBuilder});

  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.82,
      ),
      itemBuilder: itemBuilder,
    );
  }
}

class _CategoryTilePlaceholder extends StatelessWidget {
  const _CategoryTilePlaceholder();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
    );
  }
}
