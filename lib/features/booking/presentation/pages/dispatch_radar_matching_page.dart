import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/radar_pulse_animation.dart';

/// Realtime Dispatch Radar matching screen.
/// Simulates scanning within 2.5km, dispatching to 3 nearest workers, and worker accept transition.
/// Also covers the "no pro available" outcome (Cell 49) and the re-search after a pro
/// cancels (Cell 118).
class DispatchRadarMatchingPage extends StatefulWidget {
  const DispatchRadarMatchingPage({
    this.initialStage = 0,
    this.isWorkerCancelled = false,
    super.key,
  });

  /// 0: Scanning 2.5km, 1: Dispatched to 3 workers, 2: Matched with partner worker,
  /// 3: No pro available for the chosen slot
  final int initialStage;

  /// Shows the "previous pro cancelled, searching again at no cost" note while searching.
  final bool isWorkerCancelled;

  static const int stageMatched = 2;
  static const int stageNoWorker = 3;

  @override
  State<DispatchRadarMatchingPage> createState() => _DispatchRadarMatchingPageState();
}

class _DispatchRadarMatchingPageState extends State<DispatchRadarMatchingPage> {
  late int _currentStage;
  Timer? _stageTimer;

  @override
  void initState() {
    super.initState();
    _currentStage = widget.initialStage;
    if (_currentStage < 2) {
      _startStageProgression();
    }
  }

  void _startStageProgression() {
    _stageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_currentStage < 2) {
          _currentStage++;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _stageTimer?.cancel();
    super.dispose();
  }

  void _onCancelSearch() {
    unawaited(
      showDialog<void>(
        context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        title: Text(
          dialogCtx.l10n.dispatchRadarCancelSearch,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          dialogCtx.l10n.dispatchRadarCancelConfirm,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(
              dialogCtx.l10n.dialogNo,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.customerHome);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.control),
              ),
            ),
            child: Text(
              dialogCtx.l10n.dispatchRadarCancelSearch,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.surface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

  void _onViewTracking() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.dispatchRadarViewTracking),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentStage == DispatchRadarMatchingPage.stageNoWorker) {
      return _buildNoWorkerScaffold(context);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: const Border(bottom: BorderSide(color: AppColors.border)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () {
            if (_currentStage < DispatchRadarMatchingPage.stageMatched) {
              _onCancelSearch();
            } else {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.customerHome);
              }
            }
          },
        ),
        title: Text(
          context.l10n.dispatchRadarTitle,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),

              // Animated radar pulse
              const Center(
                child: RadarPulseAnimation(
                  size: 240,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              if (widget.isWorkerCancelled &&
                  _currentStage < DispatchRadarMatchingPage.stageMatched) ...[
                Container(
                  key: const Key('worker_cancelled_note'),
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(color: AppColors.warning),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 20, color: AppColors.textSecondary),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          context.l10n.dispatchRadarWorkerCancelledNote('Trần Văn Hùng'),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],

              // Stage progress & status card
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildStageStatusWidget(context),
              ),

              const Spacer(),

              // Bottom action buttons
              if (_currentStage < 2) ...[
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _onCancelSearch,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.control),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      context.l10n.dispatchRadarCancelSearch,
                      style: AppTextStyles.buttonText.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onViewTracking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.control),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      context.l10n.dispatchRadarViewTracking,
                      style: AppTextStyles.buttonText.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoWorkerScaffold(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: const Border(bottom: BorderSide(color: AppColors.border)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => context.go(AppRoutes.customerHome),
        ),
        title: Text(
          l10n.dispatchRadarTitle,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(
                          Icons.event_busy_rounded,
                          size: 40,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.dispatchRadarNoWorkerTitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineMd.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.dispatchRadarNoWorkerDesc,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppButton.primary(
                key: const Key('matching_change_time'),
                label: l10n.dispatchRadarChangeTime,
                icon: Icons.schedule_rounded,
                onPressed: () => context.go(AppRoutes.bookingStep2),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppSecondaryButton(
                key: const Key('matching_cancel_free'),
                label: l10n.dispatchRadarCancelFree,
                isFullWidth: true,
                icon: Icons.close_rounded,
                borderColor: AppColors.error,
                textColor: AppColors.error,
                onPressed: () => context.go(AppRoutes.customerHome),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.dispatchRadarNoChargeNote,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStageStatusWidget(BuildContext context) {
    if (_currentStage == 0) {
      return Container(
        key: const ValueKey('stage_0'),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.secondarySurface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                context.l10n.dispatchRadarScanning,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (_currentStage == 1) {
      return Container(
        key: const ValueKey('stage_1'),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.secondarySurface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.send_rounded,
              size: 24,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                context.l10n.dispatchRadarSentToWorkers,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Stage 2: Matched partner worker card
    return Container(
      key: const ValueKey('stage_2'),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.success, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondarySurface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.success, width: 1.5),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 28,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Nguyễn Văn Hùng',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      context.l10n.dispatchRadarWorkerRating,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: AppColors.success,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  context.l10n.dispatchRadarWorkerAssigned,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
