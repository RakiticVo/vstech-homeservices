import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Customer Cancellation Page (Concept 02 — Cells 67 & 68 `cancel`)
/// Handles both Free Cancellation (before pro accept) and Fee Cancellation (after pro accept, 50k fee).
class CustomerCancellationPage extends StatefulWidget {
  const CustomerCancellationPage({
    super.key,
    this.hasFee = false,
    this.orderCode = 'HS-2026-0012',
  });

  final bool hasFee;
  final String orderCode;

  @override
  State<CustomerCancellationPage> createState() => _CustomerCancellationPageState();
}

class _CustomerCancellationPageState extends State<CustomerCancellationPage> {
  int _selectedReasonIndex = 0;
  final TextEditingController _customReasonController = TextEditingController();

  @override
  void dispose() {
    _customReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reasons = [
      context.l10n.cancelReasonChangeSchedule,
      context.l10n.cancelReasonFoundOther,
      context.l10n.cancelReasonWrongInfo,
      context.l10n.cancelReasonLateWorker,
      context.l10n.cancelReasonOther,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.cancelTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order code & Subtitle banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: widget.hasFee
                      ? AppColors.warning.withValues(alpha: 0.08)
                      : AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(
                    color: widget.hasFee
                        ? AppColors.warning.withValues(alpha: 0.4)
                        : AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.hasFee ? Icons.info_outline_rounded : Icons.check_circle_outline_rounded,
                      color: widget.hasFee ? AppColors.warning : AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.orderCode,
                            style: AppTextStyles.labelMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.hasFee
                                ? context.l10n.cancelFeeSubtitle('50.000đ')
                                : context.l10n.cancelFreeSubtitle,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: widget.hasFee ? AppColors.textPrimary : AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Reason selection title
              Text(
                context.l10n.cancelReasonPrompt,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Reason list chips
              ...List.generate(reasons.length, (index) {
                final isSelected = _selectedReasonIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedReasonIndex = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondarySurface : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                            color: isSelected ? AppColors.primary : AppColors.textMuted,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              reasons[index],
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              // Custom reason input if "Other" is picked
              if (_selectedReasonIndex == reasons.length - 1) ...[
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _customReasonController,
                  maxLines: 3,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: context.l10n.cancelReasonOtherHint,
                    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: const EdgeInsets.all(AppSpacing.md),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.lg),

              // Policy notice card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.shield_outlined, size: 20, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        widget.hasFee
                            ? context.l10n.cancelPolicyNoteFee
                            : context.l10n.cancelPolicyNoteFree,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Action buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.hasFee
                              ? 'Đã huỷ đơn hàng ${widget.orderCode} (Phí 50.000đ)'
                              : 'Đã huỷ đơn hàng ${widget.orderCode} thành công',
                        ),
                      ),
                    );
                    unawaited(context.push(AppRoutes.customerOrders));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.hasFee ? AppColors.warning : AppColors.primary,
                    foregroundColor: widget.hasFee ? AppColors.textPrimary : AppColors.onPrimary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    widget.hasFee
                        ? context.l10n.cancelConfirmBtnFee
                        : context.l10n.cancelConfirmBtnFree,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: widget.hasFee ? AppColors.textPrimary : AppColors.onPrimary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.cancelKeepBookingBtn,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
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
