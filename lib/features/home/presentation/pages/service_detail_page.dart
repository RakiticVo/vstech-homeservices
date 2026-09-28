import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_assets.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Screen 11 — Service Detail Screen.
/// Outlines service scope, pricing, itemized package checklist, warranty badge,
/// and a single primary commitment CTA "Đặt lịch ngay".
class ServiceDetailPage extends StatelessWidget {
  const ServiceDetailPage({
    super.key,
    this.serviceId = 'clean',
  });

  final String serviceId;

  @override
  Widget build(BuildContext context) {
    // Resolve dynamic metadata based on serviceId
    String title;
    String desc;
    String price;
    String iconAsset;

    switch (serviceId) {
      case 'ac':
        title = context.l10n.svcAcTitle.replaceAll('\n', ' ');
        desc = context.l10n.acServiceDesc;
        price = '150.000đ';
        iconAsset = AppAssets.svcAc;
      case 'plumb':
        title = context.l10n.svcPlumbTitle.replaceAll('\n', ' ');
        desc = context.l10n.plumbServiceDesc;
        price = '180.000đ';
        iconAsset = AppAssets.svcPlumb;
      case 'clean':
      default:
        title = context.l10n.svcCleanTitle.replaceAll('\n', ' ');
        desc = context.l10n.cleanServiceDesc;
        price = '120.000đ';
        iconAsset = AppAssets.svcClean;
    }

    final includedItems = [
      'Khảo sát hiện trạng thiết bị & không gian miễn phí',
      'Thực hiện theo quy chuẩn an toàn 5 bước chuyên nghiệp',
      'Sử dụng dung dịch chuyên dụng diệt khuẩn 99.9%',
      'Thu dọn và vệ sinh sạch sẽ khu vực thao tác sau khi xong',
      'Bàn giao nghiệm thu cùng gia chủ và kích hoạt bảo hành điện tử',
    ];

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
          title,
          style: AppTextStyles.titleLg.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header card with big icon and price
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: AppColors.secondarySurface,
                              borderRadius: BorderRadius.circular(AppRadius.control),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Image.asset(
                              iconAsset,
                              fit: BoxFit.contain,
                              errorBuilder: (_, _, _) => const Icon(
                                Icons.home_repair_service_outlined,
                                color: AppColors.primary,
                                size: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: AppTextStyles.headlineMd.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  context.l10n.ratingReviews('4.9', 128),
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  context.l10n.startingFrom(price),
                                  style: AppTextStyles.titleLg.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Description text
                    Text(
                      desc,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),

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
                          const Icon(
                            Icons.verified_user_outlined,
                            color: AppColors.primary,
                            size: 24,
                          ),
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
                                  context.l10n.serviceDuration,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Package includes checklist
                    Text(
                      context.l10n.serviceIncluded,
                      style: AppTextStyles.titleLg.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    ...includedItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              size: 18,
                              color: AppColors.success,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                item,
                                style: AppTextStyles.bodyMd.copyWith(
                                  color: AppColors.textPrimary,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                label: context.l10n.serviceDetailBookCta,
                onPressed: () {
                  unawaited(context.push(AppRoutes.bookingStep1));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
