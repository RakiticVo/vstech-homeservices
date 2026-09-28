import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Inspection & Service Sign-off Screen (`accept` — Concept 02: Cell 50).
/// Allows the customer to review quality checklist before committing payment.
class InspectionSignoffPage extends StatefulWidget {
  const InspectionSignoffPage({
    super.key,
    this.orderCode = 'HS-2026-0012',
  });

  final String orderCode;

  @override
  State<InspectionSignoffPage> createState() => _InspectionSignoffPageState();
}

class _InspectionSignoffPageState extends State<InspectionSignoffPage> {
  final Set<int> _checkedItems = {0, 1, 2, 3, 4};

  void _toggleItem(int index) {
    setState(() {
      if (_checkedItems.contains(index)) {
        _checkedItems.remove(index);
      } else {
        _checkedItems.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final checklist = [
      context.l10n.inspectItem1,
      context.l10n.inspectItem2,
      context.l10n.inspectItem3,
      context.l10n.inspectItem4,
      context.l10n.inspectItem5,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          context.l10n.inspectTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Header Instruction Card
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
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.secondarySurface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.fact_check_outlined, color: AppColors.primary),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.inspectTitle,
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '#${widget.orderCode}',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        context.l10n.inspectSubtitle,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // 5-Item Inspection Checklist
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.inspectTitle,
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '${_checkedItems.length}/${checklist.length}',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.sm),
                for (var i = 0; i < checklist.length; i++)
                  InkWell(
                    onTap: () => _toggleItem(i),
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            _checkedItems.contains(i)
                                ? Icons.check_box_rounded
                                : Icons.check_box_outline_blank_rounded,
                            color: _checkedItems.contains(i)
                                ? AppColors.primary
                                : AppColors.textMuted,
                            size: 22,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              checklist[i],
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: _checkedItems.contains(i)
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
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

          const SizedBox(height: AppSpacing.lg),

          // 30-Day Warranty Badge
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius: BorderRadius.circular(AppRadius.control),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    context.l10n.inspectWarrantyNotice,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Primary CTA: "Nghiệm thu hài lòng"
          AppButton(
            label: context.l10n.inspectSatisfiedCta,
            onPressed: () {
              unawaited(context.push(AppRoutes.orderPaymentSummary));
            },
          ),

          const SizedBox(height: AppSpacing.sm),

          // Secondary Action: "Chưa đạt yêu cầu"
          TextButton(
            onPressed: () {
              unawaited(
                showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.surface,
                    title: Text(
                      context.l10n.inspectUnsatisfiedCta,
                      style: AppTextStyles.headlineSmall,
                    ),
                    content: const Text(
                      'Thợ đối tác sẽ thực hiện xử lý lại ngay lập tức tại chỗ cho các hạng mục chưa đạt yêu cầu mà không phát sinh thêm bất kỳ chi phí nào.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Text(
                          'Yêu cầu làm lại',
                          style: AppTextStyles.labelLarge.copyWith(color: AppColors.warning),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Text(
                          'Đóng',
                          style: AppTextStyles.labelLarge.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Text(
              context.l10n.inspectUnsatisfiedCta,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
