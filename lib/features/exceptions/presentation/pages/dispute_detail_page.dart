import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Dispute Detail Page (Concept 02 — Cells 83 & 84 `cdetail`)
/// Displays full complaint lifecycle, evidence, timeline, and resolution (refund notice or additional photo prompt).
class DisputeDetailPage extends StatefulWidget {
  const DisputeDetailPage({
    super.key,
    this.complaintId = '#KN-0228-014',
    this.orderCode = 'HS-2026-0054',
    this.isNeedInfo = false,
  });

  final String complaintId;
  final String orderCode;
  final bool isNeedInfo;

  @override
  State<DisputeDetailPage> createState() => _DisputeDetailPageState();
}

class _DisputeDetailPageState extends State<DisputeDetailPage> {
  bool _infoAdded = false;

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
          context.l10n.complaintDetailTitle,
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
              // Complaint Header Card
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.complaintId,
                            style: AppTextStyles.headlineSmall.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: widget.isNeedInfo
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : AppColors.successDark.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppRadius.chip),
                            border: Border.all(
                              color: widget.isNeedInfo
                                  ? AppColors.primary.withValues(alpha: 0.3)
                                  : AppColors.successDark.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            widget.isNeedInfo
                                ? context.l10n.complaintsTabNeedInfo
                                : context.l10n.complaintsTabResolved,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: widget.isNeedInfo ? AppColors.primary : AppColors.successDark,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      context.l10n.complaintDetailOrderCode(widget.orderCode),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      context.l10n.complaintDetailDate('28/02/2026 14:30'),
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Resolution or Action Section
              if (widget.isNeedInfo) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 20),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            'Yêu cầu bổ sung thông tin',
                            style: AppTextStyles.labelMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        context.l10n.complaintDetailAddInfoPrompt,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (!_infoAdded)
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _infoAdded = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Đã bổ sung 2 ảnh minh chứng')),
                            );
                          },
                          icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                          label: Text(context.l10n.complaintDetailAddInfoBtn),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.control),
                            ),
                          ),
                        )
                      else
                        Text(
                          'Đã gửi bổ sung thông tin thành công!',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.successDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle_outline_rounded, color: AppColors.successDark, size: 20),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            context.l10n.complaintDetailResolution,
                            style: AppTextStyles.labelMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.successDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        context.l10n.complaintDetailRefundNotice('100.000đ'),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.lg),

              // Complaint Content and Evidence Card
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
                      'Nội dung khiếu nại',
                      style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Thợ thi công giặt nệm nhưng các vết ố cạnh viền chưa được làm sạch kỹ. Nệm vẫn còn mùi ẩm sau khi thợ ra về.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Hình ảnh hiện trường (2 ảnh)',
                      style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          margin: const EdgeInsets.only(right: AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.secondarySurface,
                            borderRadius: BorderRadius.circular(AppRadius.control),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(Icons.image_rounded, color: AppColors.primary, size: 28),
                        ),
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.secondarySurface,
                            borderRadius: BorderRadius.circular(AppRadius.control),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(Icons.image_rounded, color: AppColors.primary, size: 28),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Back CTA
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
                    'Đóng chi tiết khiếu nại',
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
