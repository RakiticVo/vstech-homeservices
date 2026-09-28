import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/service_checklist_widget.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/tracking_map_widget.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/working_timer_widget.dart';

/// Customer Real-time Job Tracking Screen (Concept 02: Cells 43, 45, 47, 49).
/// Transitions across 4 stages: En Route -> Arrived -> Executing -> Pending Sign-off.
class CustomerTrackingPage extends StatefulWidget {
  const CustomerTrackingPage({
    super.key,
    this.initialStage = 1,
    this.orderCode = 'HS-2026-0012',
  });

  /// 1: En Route, 2: Arrived, 3: Executing, 4: Pending Sign-off
  final int initialStage;
  final String orderCode;

  @override
  State<CustomerTrackingPage> createState() => _CustomerTrackingPageState();
}

class _CustomerTrackingPageState extends State<CustomerTrackingPage> {
  late int _currentStage;
  final Set<int> _completedSteps = {0, 1};

  @override
  void initState() {
    super.initState();
    _currentStage = widget.initialStage;
  }

  void _onStageSelected(int stage) {
    setState(() {
      _currentStage = stage;
      if (stage >= 3) {
        _completedSteps.addAll([0, 1]);
      }
      if (stage == 4) {
        _completedSteps.addAll([0, 1, 2, 3, 4]);
      }
    });
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.trackingTitle,
              style: AppTextStyles.headlineSmall.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              context.l10n.trackingOrderCode(widget.orderCode),
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic_outlined),
            color: AppColors.textSecondary,
            tooltip: context.l10n.trackingHelpSupport,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.trackingHelpSupport)),
              );
            },
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Column(
        children: [
          // Stage Selector Simulator Chips
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            color: AppColors.surface,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _StageChip(
                    label: context.l10n.trackingStageEnRoute,
                    stageNumber: 1,
                    isSelected: _currentStage == 1,
                    onTap: () => _onStageSelected(1),
                  ),
                  const SizedBox(width: 8),
                  _StageChip(
                    label: context.l10n.trackingStageArrived,
                    stageNumber: 2,
                    isSelected: _currentStage == 2,
                    onTap: () => _onStageSelected(2),
                  ),
                  const SizedBox(width: 8),
                  _StageChip(
                    label: context.l10n.trackingStageExecuting,
                    stageNumber: 3,
                    isSelected: _currentStage == 3,
                    onTap: () => _onStageSelected(3),
                  ),
                  const SizedBox(width: 8),
                  _StageChip(
                    label: context.l10n.trackingStageSignoff,
                    stageNumber: 4,
                    isSelected: _currentStage == 4,
                    onTap: () => _onStageSelected(4),
                  ),
                ],
              ),
            ),
          ),
          Container(color: AppColors.border, height: 1),

          // Scrollable Stage Body
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // Stage 1 & 2: Map View
                if (_currentStage == 1 || _currentStage == 2) ...[
                  TrackingMapWidget(
                    height: 250,
                    workerEtaText: _currentStage == 1 ? '8 phút' : 'Đã đến',
                    destinationLabel: 'Căn hộ 802',
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // Stage 1 Status Banner
                if (_currentStage == 1)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.secondarySurface,
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.near_me_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            context.l10n.trackingEtaNotice(8, '2.4'),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Stage 2 Status Banner (Arrived Check-in)
                if (_currentStage == 2)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      border: Border.all(color: AppColors.success),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                          size: 22,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            context.l10n.trackingCheckInAt('13:58'),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Stage 3: Live Working Timer + Service Checklist
                if (_currentStage == 3) ...[
                  const WorkingTimerWidget(),
                  const SizedBox(height: AppSpacing.md),
                  ServiceChecklistWidget(
                    completedSteps: _completedSteps,
                  ),
                ],

                // Stage 4: Ready for Sign-off
                if (_currentStage == 4) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            color: AppColors.secondarySurface,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.task_alt_rounded,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          context.l10n.trackingStageSignoff,
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Thợ đã hoàn thành toàn bộ 5 bước kỹ thuật. Mời bạn kiểm tra thực tế chất lượng.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const ServiceChecklistWidget(
                    completedSteps: {0, 1, 2, 3, 4},
                    currentStep: 4,
                  ),
                ],

                const SizedBox(height: AppSpacing.lg),

                // Assigned Partner Worker Card (Present across all tracking stages)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: AppColors.secondarySurface,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person_rounded,
                                color: AppColors.primary,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.trackingWorkerName,
                                  style: AppTextStyles.headlineSmall.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  context.l10n.trackingWorkerRating,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Divider(height: 1, color: AppColors.border),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(context.l10n.trackingMaskedCall)),
                                );
                              },
                              icon: const Icon(Icons.call_rounded, size: 18),
                              label: Text(context.l10n.trackingMaskedCall),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.border),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppRadius.control),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(context.l10n.trackingChat)),
                                );
                              },
                              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                              label: Text(context.l10n.trackingChat),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.border),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppRadius.control),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Action CTA in Stage 4 (Proceed to Inspection)
                if (_currentStage == 4)
                  AppButton(
                    label: context.l10n.trackingProceedToInspection,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(context.l10n.trackingProceedToInspection)),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StageChip extends StatelessWidget {
  const _StageChip({
    required this.label,
    required this.stageNumber,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final int stageNumber;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.chip),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.border,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$stageNumber',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
