import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_assets.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen 10 — Category Browse Screen.
/// Displays comprehensive service categories with search filter chips and price estimates.
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _selectedFilterIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onServiceSelected(String serviceId) {
    unawaited(context.push('${AppRoutes.serviceDetail}?id=$serviceId'));
  }

  @override
  Widget build(BuildContext context) {
    final filters = [
      context.l10n.categoriesFilterAll,
      context.l10n.categoriesFilterClean,
      context.l10n.categoriesFilterElectric,
      context.l10n.categoriesFilterPlumb,
      context.l10n.categoriesFilterRepair,
    ];

    final allServices = [
      _ServiceItem(
        id: 'clean',
        title: context.l10n.svcCleanTitle.replaceAll('\n', ' '),
        description: context.l10n.cleanServiceDesc,
        priceText: context.l10n.startingFrom('120.000đ'),
        ratingText: '4.9 ★',
        iconAsset: AppAssets.svcClean,
        categoryIndex: 1,
      ),
      _ServiceItem(
        id: 'ac',
        title: context.l10n.svcAcTitle.replaceAll('\n', ' '),
        description: context.l10n.acServiceDesc,
        priceText: context.l10n.startingFrom('150.000đ'),
        ratingText: '4.9 ★',
        iconAsset: AppAssets.svcAc,
        categoryIndex: 2,
      ),
      _ServiceItem(
        id: 'plumb',
        title: context.l10n.svcPlumbTitle.replaceAll('\n', ' '),
        description: context.l10n.plumbServiceDesc,
        priceText: context.l10n.startingFrom('180.000đ'),
        ratingText: '4.8 ★',
        iconAsset: AppAssets.svcPlumb,
        categoryIndex: 3,
      ),
      _ServiceItem(
        id: 'laundry',
        title: context.l10n.svcLaundryTitle.replaceAll('\n', ' '),
        description: context.l10n.cleanServiceDesc,
        priceText: context.l10n.startingFrom('90.000đ'),
        ratingText: '4.7 ★',
        iconAsset: AppAssets.svcLaundry,
        categoryIndex: 1,
      ),
      _ServiceItem(
        id: 'maid',
        title: context.l10n.svcMaidTitle.replaceAll('\n', ' '),
        description: context.l10n.cleanServiceDesc,
        priceText: context.l10n.startingFrom('80.000đ/h'),
        ratingText: '4.9 ★',
        iconAsset: AppAssets.svcMaid,
        categoryIndex: 1,
      ),
      _ServiceItem(
        id: 'pest',
        title: context.l10n.svcPestTitle.replaceAll('\n', ' '),
        description: context.l10n.cleanServiceDesc,
        priceText: context.l10n.startingFrom('250.000đ'),
        ratingText: '4.8 ★',
        iconAsset: AppAssets.svcPest,
        categoryIndex: 1,
      ),
      _ServiceItem(
        id: 'install',
        title: context.l10n.svcInstallTitle.replaceAll('\n', ' '),
        description: context.l10n.plumbServiceDesc,
        priceText: context.l10n.startingFrom('150.000đ'),
        ratingText: '4.8 ★',
        iconAsset: AppAssets.svcInstall,
        categoryIndex: 4,
      ),
      _ServiceItem(
        id: 'appliance',
        title: context.l10n.svcApplianceTitle.replaceAll('\n', ' '),
        description: context.l10n.acServiceDesc,
        priceText: context.l10n.startingFrom('200.000đ'),
        ratingText: '4.9 ★',
        iconAsset: AppAssets.svcAppliance,
        categoryIndex: 4,
      ),
    ];

    final filteredServices = _selectedFilterIndex == 0
        ? allServices
        : allServices.where((s) => s.categoryIndex == _selectedFilterIndex).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.categoriesTitle,
          style: AppTextStyles.titleLg.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                height: 46,
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
                      child: TextField(
                        controller: _searchController,
                        style: AppTextStyles.bodyMd,
                        decoration: InputDecoration(
                          hintText: context.l10n.homeSearchPlaceholder,
                          hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.textMuted),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Horizontal Filter Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedFilterIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilterIndex = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondarySurface : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Text(
                        filters[index],
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Services List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: filteredServices.length,
                separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  return InkWell(
                    onTap: () => _onServiceSelected(service.id),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          // Icon container
                          Container(
                            width: 52,
                            height: 52,
                            padding: const EdgeInsets.all(AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: AppColors.secondarySurface,
                              borderRadius: BorderRadius.circular(AppRadius.control),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Image.asset(
                              service.iconAsset,
                              fit: BoxFit.contain,
                              errorBuilder: (_, _, _) => const Icon(
                                Icons.home_repair_service_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),

                          // Title, description, price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      service.title,
                                      style: AppTextStyles.titleLg.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      service.ratingText,
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.warning,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  service.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  service.priceText,
                                  style: AppTextStyles.labelMd.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          const Icon(
                            Icons.chevron_right,
                            color: AppColors.textMuted,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceItem {
  const _ServiceItem({
    required this.id,
    required this.title,
    required this.description,
    required this.priceText,
    required this.ratingText,
    required this.iconAsset,
    required this.categoryIndex,
  });

  final String id;
  final String title;
  final String description;
  final String priceText;
  final String ratingText;
  final String iconAsset;
  final int categoryIndex;
}
