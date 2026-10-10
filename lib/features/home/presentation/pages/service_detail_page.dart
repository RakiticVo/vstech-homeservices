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
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/category_detail_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/category_thumbnail.dart';

/// Screen 11 — Service Detail Screen.
/// Shows one category from `GET /service-categories/{id}` (photo, name, description, starting
/// price) with the warranty badge and a single primary CTA "Đặt lịch ngay" that starts the booking
/// flow for this category.
class ServiceDetailPage extends StatefulWidget {
  const ServiceDetailPage({required this.serviceId, super.key});

  final String serviceId;

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<CategoryDetailCubit>().load(widget.serviceId));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CategoryDetailCubit>().state;
    final category = state is CategoryDetailLoadedState ? state.category : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.customerHome);
            }
          },
        ),
        title: Text(
          category?.name ?? '',
          style: AppTextStyles.titleLg.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: switch (state) {
          CategoryDetailInitialState() || CategoryDetailLoadingState() => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          CategoryDetailErrorState(:final failure) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ErrorRetryView(
              message: context.l10n.failureMessage(failure),
              onRetry: () => unawaited(context.read<CategoryDetailCubit>().load(widget.serviceId)),
            ),
          ),
          CategoryDetailLoadedState(:final category) => _ServiceDetailBody(category: category),
        },
      ),
    );
  }
}

class _ServiceDetailBody extends StatelessWidget {
  const _ServiceDetailBody({required this.category});

  final ServiceCategory category;

  @override
  Widget build(BuildContext context) {
    final basePrice = category.basePrice;
    final description = category.description;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header card with photo and price
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      CategoryThumbnail(imageUrl: category.imageUrl, size: 64),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name,
                              style: AppTextStyles.headlineMd.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            if (basePrice != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                context.l10n.startingFrom(MoneyFormatter.format(basePrice)),
                                style: AppTextStyles.titleLg.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (description != null && description.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    description,
                    style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary, height: 1.5),
                  ),
                ],

                const SizedBox(height: AppSpacing.lg),

                // Warranty & Trust Badge
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 24),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.serviceWarrantyNotice,
                              style: AppTextStyles.labelMd.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              context.l10n.bookingPayAfterInspectNotice,
                              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom CTA Bar
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: AppButton.primary(
            key: const Key('service_detail_book_button'),
            label: context.l10n.serviceDetailBookCta,
            onPressed: () => unawaited(context.push(AppRoutes.bookingStep1Location(categoryId: category.id))),
          ),
        ),
      ],
    );
  }
}
