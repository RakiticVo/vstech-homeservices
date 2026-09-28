import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker Cancellation Page (Concept 02 — Cell 71 `wcxl`)
/// Allows a worker to cancel an accepted job with an explicit impact warning on their completion rating.
class WorkerCancellationPage extends StatefulWidget {
  const WorkerCancellationPage({
    super.key,
    this.jobCode = 'HS-2026-0012',
  });

  final String jobCode;

  @override
  State<WorkerCancellationPage> createState() => _WorkerCancellationPageState();
}

class _WorkerCancellationPageState extends State<WorkerCancellationPage> {
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
      context.l10n.workerCancelReasonVehicle,
      context.l10n.workerCancelReasonEmergency,
      context.l10n.workerCancelReasonNoContact,
      context.l10n.workerCancelReasonUnsafe,
      context.l10n.workerCancelReasonOther,
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
          context.l10n.workerCancelTitle,
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
              // Penalty Warning Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 24),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.jobCode,
                            style: AppTextStyles.labelMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            context.l10n.workerCancelWarning,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textPrimary,
                              height: 1.4,
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
                context.l10n.workerCancelReasonPrompt,
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

              // Custom explanation input if "Other" is picked
              if (_selectedReasonIndex == reasons.length - 1) ...[
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _customReasonController,
                  maxLines: 3,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: context.l10n.workerCancelReasonOtherHint,
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

              const SizedBox(height: AppSpacing.xl),

              // Keep Job CTA (Teal Primary - Safe default action)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.workerCancelKeepJobBtn,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onPrimary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // Confirm Cancellation (Outlined Red)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Đã ghi nhận huỷ công việc ${widget.jobCode}'),
                      ),
                    );
                    unawaited(context.push(AppRoutes.workerJobsHub));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.workerCancelConfirmBtn,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.error,
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
