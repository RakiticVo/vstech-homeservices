import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker weekly schedule calendar screen (Cell 123 `wcal`).
class WorkerScheduleWeekPage extends StatefulWidget {
  const WorkerScheduleWeekPage({super.key});

  @override
  State<WorkerScheduleWeekPage> createState() => _WorkerScheduleWeekPageState();
}

class _WorkerScheduleWeekPageState extends State<WorkerScheduleWeekPage> {
  int _selectedDayIndex = 4; // 0: T2 (21), 1: T3 (22), 2: T4 (23), 3: T5 (24), 4: T6 (25 - Today), 5: T7 (26), 6: CN (27)

  final List<Map<String, dynamic>> _weekDays = [
    {'day': 'T2', 'date': '21', 'jobs': 2, 'isOff': false},
    {'day': 'T3', 'date': '22', 'jobs': 3, 'isOff': false},
    {'day': 'T4', 'date': '23', 'jobs': 1, 'isOff': false},
    {'day': 'T5', 'date': '24', 'jobs': 2, 'isOff': false},
    {'day': 'T6', 'date': '25', 'jobs': 2, 'isOff': false, 'isToday': true},
    {'day': 'T7', 'date': '26', 'jobs': 1, 'isOff': false, 'hasWarranty': true},
    {'day': 'CN', 'date': '27', 'jobs': 0, 'isOff': true},
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedDay = _weekDays[_selectedDayIndex];

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
          l10n.wcalTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            tooltip: l10n.wcalSetAvailabilityCta,
            icon: const Icon(Icons.tune_outlined, color: AppColors.primary),
            onPressed: () => context.push(AppRoutes.workerAvailability),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Week Subheader with button to Availability settings
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        l10n.wcalWeekRange,
                        style: AppTextStyles.bodyMd.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => context.push(AppRoutes.workerAvailability),
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.wcalSetAvailabilityCta,
                            style: AppTextStyles.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Horizontal Week Days Strip
            SizedBox(
              height: 84,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                scrollDirection: Axis.horizontal,
                itemCount: _weekDays.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final item = _weekDays[index];
                  final isSelected = index == _selectedDayIndex;
                  final isOff = item['isOff'] as bool;
                  final jobs = item['jobs'] as int;
                  final hasWarranty = item['hasWarranty'] == true;

                  return GestureDetector(
                    key: Key('week_day_$index'),
                    onTap: () {
                      setState(() {
                        _selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      width: 58,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.secondarySurface
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['day'] as String,
                            style: AppTextStyles.caption.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['date'] as String,
                            style: AppTextStyles.headlineSm.copyWith(
                              fontWeight: FontWeight.w800,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          if (isOff)
                            Text(
                              l10n.wcalDayOff,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textMuted,
                                fontSize: 10,
                              ),
                            )
                          else if (hasWarranty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'BH',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primaryPressed,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 9,
                                ),
                              ),
                            )
                          else
                            Text(
                              l10n.wcalJobsCount(jobs),
                              style: AppTextStyles.caption.copyWith(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Selected Day Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Text(
                    '${selectedDay['day']} ${selectedDay['date']}/04',
                    style: AppTextStyles.headlineSm.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (selectedDay['isToday'] == true) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Text(
                        l10n.wcalToday,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Day Jobs List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xs,
                ),
                children: _buildJobsForSelectedDay(context, _selectedDayIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildJobsForSelectedDay(BuildContext context, int dayIndex) {
    final l10n = context.l10n;

    if (dayIndex == 6) {
      // CN: Regular day off
      return [
        _buildEmptyStateCard(
          icon: Icons.hotel_outlined,
          title: l10n.wcalDayOffRegular,
          subtitle: l10n.wcalNoJobs,
        ),
      ];
    }

    if (dayIndex == 5) {
      // T7 26/04: Warranty job
      return [
        _buildJobCard(
          time: '08:00 – 09:30',
          serviceTitle: 'Vệ sinh máy lạnh · Bảo hành kiểm tra lại',
          customerName: 'Trần Thị Bích · 0938 ••• 112',
          address: 'Chung cư Moonlight Residences, TP. Thủ Đức',
          price: '0đ',
          isWarranty: true,
          statusText: 'Đã nhận bảo hành',
          onTap: () => context.push(AppRoutes.workerWarrantyJob),
        ),
      ];
    }

    // Typical active days (e.g. T6 25/04)
    return [
      _buildJobCard(
        time: '08:30 – 10:30',
        serviceTitle: 'Vệ sinh máy lạnh treo tường (2 máy)',
        customerName: 'Nguyễn Thị Mai · 0901 ••• 567',
        address: 'Căn hộ Flora Novia, Phạm Văn Đồng, Thủ Đức',
        price: '360.000đ',
        statusText: 'Đã xác nhận',
        onTap: () => context.push(AppRoutes.workerJobDetail),
      ),
      const SizedBox(height: AppSpacing.md),
      _buildJobCard(
        time: '14:00 – 16:00',
        serviceTitle: 'Sửa chữa vòi sen rò rỉ & thay ống nước',
        customerName: 'Lê Hoàng Nam · 0912 ••• 889',
        address: '142 Võ Văn Ngân, P. Linh Chiểu, Thủ Đức',
        price: '200.000đ',
        statusText: 'Sắp tới',
        onTap: () => context.push(AppRoutes.workerJobDetail),
      ),
    ];
  }

  Widget _buildJobCard({
    required String time,
    required String serviceTitle,
    required String customerName,
    required String address,
    required String price,
    required String statusText,
    required VoidCallback onTap,
    bool isWarranty = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: isWarranty ? AppColors.primary : AppColors.border,
            width: isWarranty ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: AppTextStyles.bodySm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                if (isWarranty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondarySurface,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      'BẢO HÀNH 0đ',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                else
                  Text(
                    price,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              serviceTitle,
              style: AppTextStyles.bodyMd.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 15,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    customerName,
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 15,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    address,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyStateCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: AppColors.textMuted),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
