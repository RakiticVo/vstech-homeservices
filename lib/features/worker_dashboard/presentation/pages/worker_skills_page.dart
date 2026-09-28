import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Worker skills and certificates management screen (Cell 126 `wskill`).
class WorkerSkillsPage extends StatefulWidget {
  const WorkerSkillsPage({super.key});

  @override
  State<WorkerSkillsPage> createState() => _WorkerSkillsPageState();
}

class _WorkerSkillsPageState extends State<WorkerSkillsPage> {
  final Set<String> _enabledServices = {
    'clean',
    'ac',
    'plumb',
    'install',
    'laundry',
    'maid',
    'pest',
    'appliance',
  };

  final List<Map<String, dynamic>> _services = [
    {
      'id': 'clean',
      'title': 'Vệ sinh nhà cửa',
      'icon': Icons.cleaning_services_outlined,
      'isOutdoor': false,
    },
    {
      'id': 'ac',
      'title': 'Vệ sinh máy lạnh',
      'icon': Icons.ac_unit_outlined,
      'isOutdoor': true,
    },
    {
      'id': 'plumb',
      'title': 'Sửa chữa điện nước',
      'icon': Icons.plumbing_outlined,
      'isOutdoor': false,
    },
    {
      'id': 'install',
      'title': 'Lắp đặt thiết bị',
      'icon': Icons.build_outlined,
      'isOutdoor': true,
    },
    {
      'id': 'laundry',
      'title': 'Giặt sấy · Rèm - Sofa',
      'icon': Icons.local_laundry_service_outlined,
      'isOutdoor': false,
    },
    {
      'id': 'maid',
      'title': 'Giúp việc theo giờ',
      'icon': Icons.person_search_outlined,
      'isOutdoor': false,
    },
    {
      'id': 'pest',
      'title': 'Diệt côn trùng',
      'icon': Icons.pest_control_outlined,
      'isOutdoor': true,
    },
    {
      'id': 'appliance',
      'title': 'Thiết bị gia dụng',
      'icon': Icons.kitchen_outlined,
      'isOutdoor': false,
    },
  ];

  void _toggleService(String id) {
    setState(() {
      if (_enabledServices.contains(id)) {
        if (_enabledServices.length > 1) {
          _enabledServices.remove(id);
        }
      } else {
        _enabledServices.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.workerDashboard);
            }
          },
        ),
        title: Text(
          l10n.wskillTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expiry Warning Banner
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(
                          color: AppColors.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppColors.error,
                            size: 22,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.wskillExpiredBannerTitle,
                                  style: AppTextStyles.bodyMd.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.error,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.wskillExpiredBannerDesc,
                                  style: AppTextStyles.bodySm.copyWith(
                                    color: AppColors.textSecondary,
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

                    // Section 1: Services Offered
                    Text(
                      l10n.wskillServicesTitle,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Services 2-column Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.2,
                      ),
                      itemCount: _services.length,
                      itemBuilder: (context, index) {
                        final svc = _services[index];
                        final id = svc['id'] as String;
                        final isEnabled = _enabledServices.contains(id);
                        final isOutdoor = svc['isOutdoor'] as bool;

                        return InkWell(
                          key: Key('service_chip_$id'),
                          onTap: () => _toggleService(id),
                          borderRadius:
                              BorderRadius.circular(AppRadius.control),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isEnabled
                                  ? AppColors.secondarySurface
                                  : AppColors.surface,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.control),
                              border: Border.all(
                                color: isEnabled
                                    ? AppColors.primary
                                    : AppColors.border,
                                width: isEnabled ? 1.5 : 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  svc['icon'] as IconData,
                                  size: 20,
                                  color: isEnabled
                                      ? AppColors.primary
                                      : AppColors.textMuted,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        svc['title'] as String,
                                        style: AppTextStyles.caption.copyWith(
                                          fontWeight: isEnabled
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          color: isEnabled
                                              ? AppColors.textPrimary
                                              : AppColors.textMuted,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (isOutdoor) ...[
                                        const SizedBox(height: 2),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 1,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.error
                                                .withValues(alpha: 0.12),
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Text(
                                            l10n.wskillHiddenTag,
                                            style:
                                                AppTextStyles.caption.copyWith(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Section 2: Certificates List
                    Text(
                      l10n.wskillCertsTitle,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    _buildCertCard(
                      title: 'Chứng chỉ an toàn làm việc trên cao',
                      expiry: 'Hết hạn 15/04/2025',
                      statusBadge: l10n.wskillCertExpired,
                      isExpired: true,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildCertCard(
                      title: 'Chứng chỉ điện dân dụng bậc 3',
                      expiry: 'Hết hạn 10/2027',
                      statusBadge: l10n.wskillCertApproved,
                      isApproved: true,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildCertCard(
                      title: 'Chứng nhận kỹ thuật máy lạnh Daikin',
                      expiry: 'Hết hạn 06/2026',
                      statusBadge: l10n.wskillCertApproved,
                      isApproved: true,
                    ),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: AppButton(
                key: const Key('upload_cert_button'),
                label: l10n.wskillUploadCta,
                onPressed: () => context.push(AppRoutes.workerUploadCert),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertCard({
    required String title,
    required String expiry,
    required String statusBadge,
    bool isExpired = false,
    bool isApproved = false,
  }) {
    final badgeBg = isExpired
        ? AppColors.error.withValues(alpha: 0.12)
        : AppColors.secondarySurface;
    final badgeColor = isExpired ? AppColors.error : AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: isExpired
              ? AppColors.error.withValues(alpha: 0.4)
              : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(AppRadius.control),
            ),
            child: Icon(
              isExpired ? Icons.warning_amber_rounded : Icons.verified_outlined,
              color: badgeColor,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMd.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  expiry,
                  style: AppTextStyles.bodySm.copyWith(
                    color: isExpired ? AppColors.error : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(AppRadius.chip),
              border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
            ),
            child: Text(
              statusBadge,
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w800,
                color: badgeColor,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
