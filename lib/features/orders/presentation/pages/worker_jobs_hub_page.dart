import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_floating_dock.dart';

/// Worker Jobs Hub Screen (`wjobs` — Concept 02: Cells 40–42).
/// Displays: Assigned (Mới phân công), Active (Đang làm), and Completed (Đã hoàn tất) jobs
/// with fixed capsule bottom navigation dock for the Worker role.
class WorkerJobsHubPage extends StatefulWidget {
  const WorkerJobsHubPage({
    super.key,
    this.initialTab = 0,
  });

  final int initialTab;

  @override
  State<WorkerJobsHubPage> createState() => _WorkerJobsHubPageState();
}

class _WorkerJobsHubPageState extends State<WorkerJobsHubPage> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  String _formatPrice(int amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

  void _onDockTabSelected(int index) {
    if (index == 0) return; // already here
    if (index == 1) {
      // schedule / calendar
    } else if (index == 2) {
      // wallet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          context.l10n.workerJobsTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
            onPressed: () {
              unawaited(context.push(AppRoutes.workerNotifications));
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 3-Segment Filter Bar
              Container(
                color: AppColors.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    _buildTabItem(0, context.l10n.workerJobsTabAssigned),
                    const SizedBox(width: AppSpacing.sm),
                    _buildTabItem(1, context.l10n.workerJobsTabActive),
                    const SizedBox(width: AppSpacing.sm),
                    _buildTabItem(2, context.l10n.workerJobsTabCompleted),
                  ],
                ),
              ),
              Container(color: AppColors.border, height: 1),

              // Jobs List Body
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.dockClearanceMax,
                  ),
                  children: [
                    if (_selectedTab == 0) ...[
                      // Assigned Job Card (Cell 40)
                      _buildAssignedJobCard(
                        code: 'HS-2026-0012',
                        serviceName: 'Dọn dẹp căn hộ tiêu chuẩn',
                        schedule: 'Hôm nay · 14:00 - 16:00',
                        address: 'Căn hộ 802, Tháp B, Flora Novia, TP. Thủ Đức',
                        distanceKm: '2.4',
                        netPayout: 340000,
                      ),
                    ] else if (_selectedTab == 1) ...[
                      // Active Job Card (Cell 41)
                      _buildActiveJobCard(
                        code: 'HS-2026-0012',
                        serviceName: 'Dọn dẹp căn hộ tiêu chuẩn',
                        customerName: 'Chị Mai (0912***789)',
                        timeElapsed: '00:35:12',
                        address: 'Căn hộ 802, Tháp B, Flora Novia, TP. Thủ Đức',
                        netPayout: 340000,
                      ),
                    ] else ...[
                      // Completed Job Card (Cell 42)
                      _buildCompletedJobCard(
                        code: 'HS-2026-0008',
                        serviceName: 'Sửa chữa & Thay ron vòi sen tăng áp',
                        completedAt: '20/09/2026 · 15:30',
                        netPayout: 340000,
                        customerRating: '5.0 ★',
                        customerComment: 'Thợ nhiệt tình, làm sạch sẽ, đúng giờ.',
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // Floating Capsule Bottom Dock for Worker
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: WorkerFloatingDock(
              currentIndex: 0, // Jobs tab
              onTabSelected: _onDockTabSelected,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String label) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        borderRadius: BorderRadius.circular(AppRadius.control),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondarySurface : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAssignedJobCard({
    required String code,
    required String serviceName,
    required String schedule,
    required String address,
    required String distanceKm,
    required int netPayout,
  }) {
    return Container(
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
                  code,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.near_me_outlined, size: 14, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      context.l10n.workerJobsDistance(distanceKm),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            serviceName,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  schedule,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  address,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.l10n.workerJobsEarningsEst(_formatPrice(netPayout)),
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.successDark,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    unawaited(context.push(AppRoutes.workerJobDetail));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.ordersViewDetailCta,
                    style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  label: context.l10n.workerJobsAcceptJob,
                  onPressed: () {
                    unawaited(context.push(AppRoutes.workerEnRoute));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveJobCard({
    required String code,
    required String serviceName,
    required String customerName,
    required String timeElapsed,
    required String address,
    required int netPayout,
  }) {
    return Container(
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
                  code,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Text(
                  context.l10n.trackingStageExecuting,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            serviceName,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            customerName,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 2),
          Text(
            address,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    timeElapsed,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                '+${_formatPrice(netPayout)}',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.successDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: context.l10n.workerJobsGoToWork,
            icon: Icons.play_arrow_rounded,
            onPressed: () {
              unawaited(context.push(AppRoutes.workerExecuting));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedJobCard({
    required String code,
    required String serviceName,
    required String completedAt,
    required int netPayout,
    required String customerRating,
    required String customerComment,
  }) {
    return Container(
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
                  code,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.success),
                ),
                child: Text(
                  context.l10n.workerJobsCompletedBadge,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.successDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            serviceName,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            completedAt,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius: BorderRadius.circular(AppRadius.control),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 16, color: AppColors.warning),
                    const SizedBox(width: 4),
                    Text(
                      customerRating,
                      style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '"$customerComment"',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.l10n.receiptWorkerPayout,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '+${_formatPrice(netPayout)}',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: 16,
                  color: AppColors.successDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
