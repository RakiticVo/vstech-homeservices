import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Warranty Status Timeline Screen (`bhstat` — Cell 90).
///
/// 4-stage resolution tracking:
/// 0: Đã gửi (Submitted)
/// 1: Thợ đã nhận (Accepted by Pro)
/// 2: Đang xử lý (In progress)
/// 3: Đã khắc phục (Resolved)
class WarrantyStatusPage extends StatefulWidget {
  const WarrantyStatusPage({
    super.key,
    this.stage = 1,
  });

  final int stage;

  @override
  State<WarrantyStatusPage> createState() => _WarrantyStatusPageState();
}

class _WarrantyStatusPageState extends State<WarrantyStatusPage> {
  late int _currentStage;

  @override
  void initState() {
    super.initState();
    _currentStage = widget.stage.clamp(0, 3);
  }

  @override
  Widget build(BuildContext context) {
    final stepLabels = [
      (context.l10n.warrantyStepSubmitted, '25/04 16:40'),
      (context.l10n.warrantyStepAccepted, '25/04 17:05'),
      (context.l10n.warrantyStepProcessing, '26/04 08:10'),
      (context.l10n.warrantyStepResolved, '26/04 09:05'),
    ];

    String noteText;
    if (_currentStage == 0) {
      noteText = context.l10n.warrantyNoteSubmitted;
    } else if (_currentStage == 3) {
      noteText = context.l10n.warrantyNoteResolved;
    } else {
      noteText = context.l10n.warrantyNoteProcessing;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.customerOrders);
            }
          },
        ),
        title: Text(
          context.l10n.warrantyStatusTitle,
          style: GoogleFonts.sourceSans3(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // Top Summary Card
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
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F1EA),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              context.l10n.warrantyBadgeTag,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: const Color(0xFF0E5952),
                                fontWeight: FontWeight.w800,
                                fontSize: 9.5,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Flexible(
                            child: Text(
                              context.l10n.warrantyStatusCode,
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Vệ sinh & Bảo dưỡng Máy lạnh Inverter · 0đ',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Máy lạnh chảy nước sau khi vệ sinh',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // 4-Stage Timeline Card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < stepLabels.length; i++)
                        _buildTimelineStep(
                          title: stepLabels[i].$1,
                          timestamp: i <= _currentStage ? stepLabels[i].$2 : '',
                          isCompleted: i < _currentStage,
                          isActive: i == _currentStage,
                          isLast: i == stepLabels.length - 1,
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Contextual Note Box
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          noteText,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom CTA
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: AppButton(
              label: context.l10n.warrantyBackToOrdersCta,
              icon: Icons.list_alt_rounded,
              onPressed: () => context.go(AppRoutes.customerOrders),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String timestamp,
    required bool isCompleted,
    required bool isActive,
    required bool isLast,
  }) {
    Color dotBg;
    Color dotBorder;
    Widget? dotChild;

    if (isCompleted) {
      dotBg = AppColors.primary;
      dotBorder = AppColors.primary;
      dotChild = const Icon(Icons.check, size: 12, color: Colors.white);
    } else if (isActive) {
      dotBg = AppColors.surface;
      dotBorder = AppColors.primary;
      dotChild = Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
      );
    } else {
      dotBg = AppColors.surface;
      dotBorder = AppColors.border;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Indicator column
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: dotBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: dotBorder, width: 2),
                ),
                alignment: Alignment.center,
                child: dotChild,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? AppColors.primary : AppColors.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),

          // Text content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isActive || isCompleted
                            ? AppColors.textPrimary
                            : AppColors.textMuted,
                        fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                      ),
                    ),
                  ),
                  if (timestamp.isNotEmpty) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      timestamp,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
