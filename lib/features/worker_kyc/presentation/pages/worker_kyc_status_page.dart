import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker KYC Application Status Screen.
/// Supports 3 states:
/// - `pending`: Application is under 24h review.
/// - `needs`: Documents rejected or need re-upload (e.g. glare on ID back).
/// - `approved`: Successfully onboarded -> CTA to start taking jobs on Worker Dashboard.
class WorkerKycStatusPage extends StatefulWidget {
  const WorkerKycStatusPage({
    this.initialStatus = 'pending',
    super.key,
  });

  final String initialStatus;

  @override
  State<WorkerKycStatusPage> createState() => _WorkerKycStatusPageState();
}

class _WorkerKycStatusPageState extends State<WorkerKycStatusPage> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
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
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary),
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.workerDashboard),
        ),
        title: Text(
          context.l10n.kycStatusTitle,
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
        child: Column(
          children: [
            // Status preview toggle for testing all states
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StatusChoiceChip(
                    label: context.l10n.kycStatusPendingChip,
                    isSelected: _status == 'pending',
                    onSelected: () => setState(() => _status = 'pending'),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  _StatusChoiceChip(
                    label: context.l10n.kycStatusNeedsChip,
                    isSelected: _status == 'needs',
                    onSelected: () => setState(() => _status = 'needs'),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  _StatusChoiceChip(
                    label: context.l10n.kycStatusApprovedChip,
                    isSelected: _status == 'approved',
                    onSelected: () => setState(() => _status = 'approved'),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildStatusIcon(),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          _getStatusTitle(),
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          _getStatusDescription(),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Pinned Bottom Action CTA
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: _buildActionButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    switch (_status) {
      case 'needs':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.error_outline_rounded, size: 44, color: AppColors.error),
          ),
        );
      case 'approved':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.check_circle_outline_rounded, size: 44, color: AppColors.successDark),
          ),
        );
      case 'pending':
      default:
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.hourglass_top_rounded, size: 44, color: AppColors.warning),
          ),
        );
    }
  }

  String _getStatusTitle() {
    switch (_status) {
      case 'needs':
        return context.l10n.kycNeedsInfoTitle;
      case 'approved':
        return context.l10n.kycApprovedTitle;
      case 'pending':
      default:
        return context.l10n.kycPendingTitle;
    }
  }

  String _getStatusDescription() {
    switch (_status) {
      case 'needs':
        return context.l10n.kycNeedsInfoDesc;
      case 'approved':
        return context.l10n.kycApprovedDesc;
      case 'pending':
      default:
        return context.l10n.kycPendingDesc;
    }
  }

  Widget _buildActionButton() {
    switch (_status) {
      case 'needs':
        return ElevatedButton(
          onPressed: () {
            unawaited(context.push('${AppRoutes.workerKyc}?step=3'));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: AppColors.onPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.control),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            context.l10n.kycReuploadId,
            style: AppTextStyles.buttonText.copyWith(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      case 'approved':
        return ElevatedButton(
          onPressed: () {
            context.go(AppRoutes.workerDashboard);
          },
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
            context.l10n.kycStartJobsCta,
            style: AppTextStyles.buttonText.copyWith(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      case 'pending':
      default:
        return OutlinedButton(
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.workerDashboard),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.control),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            context.l10n.back,
            style: AppTextStyles.buttonText.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        );
    }
  }
}

class _StatusChoiceChip extends StatelessWidget {
  const _StatusChoiceChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
