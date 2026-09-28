import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker Dispute Notification & Reply Page (Concept 02 — Cells 85 & 87 `wwait` dispute / `wreply`)
/// Displays escrow hold notice for worker's payout (340k) and allows submitting an explanation with photo proof.
class WorkerDisputeNotificationPage extends StatefulWidget {
  const WorkerDisputeNotificationPage({
    super.key,
    this.jobCode = 'HS-2026-0012',
    this.heldAmount = '340.000đ',
  });

  final String jobCode;
  final String heldAmount;

  @override
  State<WorkerDisputeNotificationPage> createState() => _WorkerDisputeNotificationPageState();
}

class _WorkerDisputeNotificationPageState extends State<WorkerDisputeNotificationPage> {
  final TextEditingController _replyController = TextEditingController();
  bool _photoAttached = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          context.l10n.workerDisputeTitle,
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
              // Escrow Held Notice Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lock_clock_rounded, color: AppColors.warning, size: 24),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tiền công đang tạm giữ',
                            style: AppTextStyles.labelLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            context.l10n.workerDisputeWarning(widget.jobCode, widget.heldAmount),
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

              const SizedBox(height: AppSpacing.lg),

              // Customer Claim Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.workerDisputeClaimSection,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Khách hàng phản ánh máy lạnh sau khi vệ sinh vẫn bị nhỏ giọt nước ở góc trái dàn lạnh và yêu cầu kiểm tra lại hoặc hoàn tiền.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Worker Explanation Input
              Text(
                context.l10n.workerDisputeReplyPrompt,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _replyController,
                maxLines: 4,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: context.l10n.workerDisputeReplyHint,
                  hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
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

              const SizedBox(height: AppSpacing.md),

              // Attachment Box
              InkWell(
                onTap: () {
                  setState(() {
                    _photoAttached = !_photoAttached;
                  });
                },
                borderRadius: BorderRadius.circular(AppRadius.control),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: _photoAttached ? AppColors.secondarySurface : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(
                      color: _photoAttached ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _photoAttached ? Icons.check_circle_rounded : Icons.add_photo_alternate_outlined,
                        color: _photoAttached ? AppColors.primary : AppColors.textMuted,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          _photoAttached
                              ? 'Đã đính kèm ảnh nghiệm thu (nghiem_thu_may_lanh.jpg)'
                              : 'Đính kèm ảnh đo áp suất / nghiệm thu',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: _photoAttached ? AppColors.primary : AppColors.textSecondary,
                            fontWeight: _photoAttached ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Submit Explanation CTA
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã gửi bản giải trình đến bộ phận phân xử VSTech')),
                    );
                    unawaited(context.push(AppRoutes.workerJobsHub));
                  },
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
                    context.l10n.workerDisputeSubmitReplyBtn,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onPrimary,
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
