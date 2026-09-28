import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Customer Dispute List Page (Concept 02 — Cell 82 `clist`)
/// Displays all complaints created by the customer across 4 statuses:
/// Đang xem xét · Cần bổ sung · Đã giải quyết · Đã đóng
class CustomerDisputeListPage extends StatefulWidget {
  const CustomerDisputeListPage({super.key});

  @override
  State<CustomerDisputeListPage> createState() => _CustomerDisputeListPageState();
}

class _CustomerDisputeListPageState extends State<CustomerDisputeListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          context.l10n.complaintsTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(49),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: AppColors.primary,
                indicatorWeight: 2.5,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700),
                unselectedLabelStyle: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w500),
                tabs: [
                  Tab(text: context.l10n.complaintsTabReviewing),
                  Tab(text: context.l10n.complaintsTabNeedInfo),
                  Tab(text: context.l10n.complaintsTabResolved),
                  Tab(text: context.l10n.complaintsTabClosed),
                ],
              ),
              Container(color: AppColors.border, height: 1),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Under Review tab
          _buildDisputeList([
            _DisputeItemData(
              id: '#KN-0425-031',
              orderCode: 'HS-2026-0012',
              serviceName: 'Vệ sinh máy lạnh',
              date: '25/04/2026',
              issueType: 'Chất lượng không đạt',
              statusText: 'Đang xem xét',
              statusColor: AppColors.warning,
              summary: 'Tiền thanh toán 400.000đ đang được đóng băng an toàn',
            ),
          ]),

          // 2. Needs Info tab
          _buildDisputeList([
            _DisputeItemData(
              id: '#KN-0420-028',
              orderCode: 'HS-2026-0009',
              serviceName: 'Dọn dẹp căn hộ',
              date: '20/04/2026',
              issueType: 'Thiếu hình ảnh thiết bị',
              statusText: 'Cần bổ sung',
              statusColor: AppColors.primary,
              summary: 'Chuyên viên yêu cầu bổ sung ảnh chụp sàn nhà',
              needsAction: true,
            ),
          ]),

          // 3. Resolved tab
          _buildDisputeList([
            _DisputeItemData(
              id: '#KN-0228-014',
              orderCode: 'HS-2026-0054',
              serviceName: 'Giặt sofa - nệm',
              date: '28/02/2026',
              issueType: 'Vết ố chưa sạch',
              statusText: 'Đã giải quyết',
              statusColor: AppColors.successDark,
              summary: 'Hoàn tiền 100.000đ vào ví ZaloPay',
            ),
          ]),

          // 4. Closed tab
          _buildDisputeList([
            _DisputeItemData(
              id: '#KN-0115-002',
              orderCode: 'HS-2026-0021',
              serviceName: 'Sửa điện gia dụng',
              date: '15/01/2026',
              issueType: 'Không xác định lỗi',
              statusText: 'Đã đóng',
              statusColor: AppColors.textMuted,
              summary: 'Khiếu nại không hợp lệ, đơn đã quyết toán',
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildDisputeList(List<_DisputeItemData> items) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          context.l10n.complaintsEmpty,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            unawaited(context.push('${AppRoutes.disputeDetail}?id=${item.id}'));
          },
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
                        item.id,
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: item.statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: item.statusColor.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        item.statusText,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: item.statusColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${item.serviceName} • ${context.l10n.complaintDetailOrderCode(item.orderCode)}',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 2),
                Text(
                  context.l10n.complaintDetailDate(item.date),
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                ),
                const SizedBox(height: AppSpacing.sm),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.summary,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: item.needsAction ? AppColors.primary : AppColors.textSecondary,
                          fontWeight: item.needsAction ? FontWeight.w600 : FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DisputeItemData {
  _DisputeItemData({
    required this.id,
    required this.orderCode,
    required this.serviceName,
    required this.date,
    required this.issueType,
    required this.statusText,
    required this.statusColor,
    required this.summary,
    this.needsAction = false,
  });

  final String id;
  final String orderCode;
  final String serviceName;
  final String date;
  final String issueType;
  final String statusText;
  final Color statusColor;
  final String summary;
  final bool needsAction;
}
