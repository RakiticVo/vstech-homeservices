import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/categories_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/category_thumbnail.dart';

/// Screen 10 — Category Browse Screen.
/// Lists every active service category from `GET /service-categories` with a local search filter
/// and the starting price (`basePrice`).
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onServiceSelected(String serviceId) {
    unawaited(context.push('${AppRoutes.serviceDetail}?id=$serviceId'));
  }

  /// Case- and accent-insensitive enough for Vietnamese input: compares lower-cased text.
  List<ServiceCategory> _filter(List<ServiceCategory> categories) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return categories;
    return [
      for (final category in categories)
        if (category.name.toLowerCase().contains(query) ||
            (category.description?.toLowerCase().contains(query) ?? false))
          category,
    ];
  }

  @override
  Widget build(BuildContext context) {
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
          style: AppTextStyles.titleLg.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar (filters the loaded catalogue locally — the API has no search parameter)
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
                        key: const Key('categories_search_field'),
                        controller: _searchController,
                        onChanged: (value) => setState(() => _query = value),
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

            // Services List
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) => switch (state) {
                  CategoriesInitialState() || CategoriesLoadingState() => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                  CategoriesErrorState(:final failure) => Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: ErrorRetryView(
                      message: context.l10n.failureMessage(failure),
                      onRetry: () => unawaited(context.read<CategoriesCubit>().load()),
                    ),
                  ),
                  CategoriesLoadedState(:final categories) => _buildList(_filter(categories)),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<ServiceCategory> services) {
    if (services.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Text(
          _query.isEmpty ? context.l10n.categoriesEmpty : context.l10n.categoriesNoMatch,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: services.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final service = services[index];
        final basePrice = service.basePrice;
        return InkWell(
          key: Key('category_item_${service.id}'),
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
                CategoryThumbnail(imageUrl: service.imageUrl, size: 52),
                const SizedBox(width: AppSpacing.md),

                // Title, description, price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: AppTextStyles.titleLg.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (service.description != null && service.description!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          service.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                      if (basePrice != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          context.l10n.startingFrom(MoneyFormatter.format(basePrice)),
                          style: AppTextStyles.labelMd.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
