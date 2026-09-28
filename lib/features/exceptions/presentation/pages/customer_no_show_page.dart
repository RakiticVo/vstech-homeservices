import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

enum NoShowFlowState { waiting, reporting, completed }

/// Customer No-show Management Page (Concept 02 — Cells 73, 74, 75 `wns`, `wnsrep`, `wnsdone`)
/// Allows the worker to wait 15 minutes, upload front-door photo evidence, and receive a 50k compensation fee.
class CustomerNoShowPage extends StatefulWidget {
  const CustomerNoShowPage({
    super.key,
    this.jobCode = 'HS-2026-0012',
    this.customerName = 'Chị Lan',
    this.initialState = NoShowFlowState.waiting,
  });

  final String jobCode;
  final String customerName;
  final NoShowFlowState initialState;

  @override
  State<CustomerNoShowPage> createState() => _CustomerNoShowPageState();
}

class _CustomerNoShowPageState extends State<CustomerNoShowPage> {
  late NoShowFlowState _currentState;
  int _remainingSeconds = 15 * 60; // 15 minutes default
  Timer? _timer;
  bool _hasUploadedProof = false;

  @override
  void initState() {
    super.initState();
    _currentState = widget.initialState;
    if (_currentState == NoShowFlowState.waiting) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTimer(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
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
          _currentState == NoShowFlowState.completed
              ? context.l10n.noShowSuccessTitle
              : context.l10n.noShowTitle,
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
          child: _buildCurrentStateView(),
        ),
      ),
    );
  }

  Widget _buildCurrentStateView() {
    switch (_currentState) {
      case NoShowFlowState.waiting:
        return _buildWaitingView();
      case NoShowFlowState.reporting:
        return _buildReportingView();
      case NoShowFlowState.completed:
        return _buildCompletedView();
    }
  }

  Widget _buildWaitingView() {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.md),
        // Timer Container
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
            border: Border.all(color: AppColors.primary, width: 3),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer_outlined, color: AppColors.primary, size: 28),
              const SizedBox(height: 4),
              Text(
                _formatTimer(_remainingSeconds),
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        Text(
          context.l10n.noShowSubtitle,
          style: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          context.l10n.noShowTimerDesc,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppSpacing.xl),

        // Quick Reminder Contact Actions
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đang gọi cho khách hàng ${widget.customerName}')),
                    );
                  },
                  icon: const Icon(Icons.phone_outlined, size: 18, color: AppColors.primary),
                  label: Text(
                    context.l10n.noShowCallReminder,
                    style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
                      SnackBar(content: Text('Đang mở trò chuyện với ${widget.customerName}')),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18, color: AppColors.primary),
                  label: Text(
                    context.l10n.noShowChatReminder,
                    style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        // Button to proceed to report no-show
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _currentState = NoShowFlowState.reporting;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.control),
              ),
            ),
            child: Text(
              context.l10n.noShowReportBtn,
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportingView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.noShowUploadEvidencePrompt,
          style: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Photo Upload Box
        InkWell(
          onTap: () {
            setState(() {
              _hasUploadedProof = !_hasUploadedProof;
            });
          },
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: _hasUploadedProof ? AppColors.secondarySurface : AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(
                color: _hasUploadedProof ? AppColors.primary : AppColors.border,
                width: _hasUploadedProof ? 1.5 : 1.0,
              ),
            ),
            child: _hasUploadedProof
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 40),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Đã đính kèm ảnh hiện trường (cua_nha_dong.jpg)',
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Chạm để đổi ảnh',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt_outlined, color: AppColors.textMuted, size: 40),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        context.l10n.noShowUploadBtn,
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        // Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _currentState = NoShowFlowState.completed;
              });
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
              context.l10n.noShowConfirmReportBtn,
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedView() {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xl),
        const CircleAvatar(
          radius: 36,
          backgroundColor: AppColors.secondarySurface,
          child: Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 48),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          context.l10n.noShowSuccessTitle,
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            context.l10n.noShowSuccessDesc,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        // Payout compensation card (Deep Teal accent)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: const Color(0xFF0E5952),
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bồi hoàn chi phí di chuyển',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '+50.000đ',
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Mã giao dịch: TX-NS-2026-0012',
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white60),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        // Back to Jobs Hub CTA
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
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
              context.l10n.noShowBackHomeBtn,
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
