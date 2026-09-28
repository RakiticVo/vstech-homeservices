import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Worker weekly availability & emergency time-off screen (Cell 124 `wavail`).
class WorkerAvailabilityPage extends StatefulWidget {
  const WorkerAvailabilityPage({super.key});

  @override
  State<WorkerAvailabilityPage> createState() => _WorkerAvailabilityPageState();
}

class _WorkerAvailabilityPageState extends State<WorkerAvailabilityPage> {
  static const List<String> _timeRanges = [
    '08:00 – 18:00',
    '07:00 – 20:00',
    '13:00 – 21:00',
  ];

  late List<Map<String, dynamic>> _schedule;
  final Set<String> _timeOffDays = {};

  @override
  void initState() {
    super.initState();
    _schedule = [
      {'day': 'Thứ 2 (T2)', 'enabled': true, 'rangeIndex': 0},
      {'day': 'Thứ 3 (T3)', 'enabled': true, 'rangeIndex': 0},
      {'day': 'Thứ 4 (T4)', 'enabled': true, 'rangeIndex': 0},
      {'day': 'Thứ 5 (T5)', 'enabled': true, 'rangeIndex': 1},
      {'day': 'Thứ 6 (T6)', 'enabled': true, 'rangeIndex': 0},
      {'day': 'Thứ 7 (T7)', 'enabled': true, 'rangeIndex': 2},
      {'day': 'Chủ nhật (CN)', 'enabled': false, 'rangeIndex': 0},
    ];
  }

  void _cycleTimeRange(int dayIndex) {
    if (_schedule[dayIndex]['enabled'] != true) return;
    setState(() {
      final current = _schedule[dayIndex]['rangeIndex'] as int;
      _schedule[dayIndex]['rangeIndex'] = (current + 1) % _timeRanges.length;
    });
  }

  void _toggleTimeOff(String date) {
    setState(() {
      if (_timeOffDays.contains(date)) {
        _timeOffDays.remove(date);
      } else {
        _timeOffDays.add(date);
      }
    });
  }

  void _saveSchedule() {
    final l10n = context.l10n;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.wavailSavedSuccess),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    if (context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasWarrantyWarning = _timeOffDays.contains('26/04');

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
              context.pop();
            }
          },
        ),
        title: Text(
          l10n.wavailTitle,
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
                    // Section 1: Weekly Schedule
                    Text(
                      l10n.wavailWeeklySchedule,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.wavailTapToCycle,
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Weekly days list card
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _schedule.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1, color: AppColors.border),
                        itemBuilder: (context, index) {
                          final item = _schedule[index];
                          final isEnabled = item['enabled'] as bool;
                          final rangeIndex = item['rangeIndex'] as int;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                // Toggle active switch
                                Switch.adaptive(
                                  key: Key('avail_switch_$index'),
                                  value: isEnabled,
                                  activeTrackColor: AppColors.primary,
                                  onChanged: (val) {
                                    setState(() {
                                      item['enabled'] = val;
                                    });
                                  },
                                ),
                                const SizedBox(width: AppSpacing.xs),

                                // Day label
                                Expanded(
                                  child: Text(
                                    item['day'] as String,
                                    style: AppTextStyles.bodyMd.copyWith(
                                      fontWeight: isEnabled
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isEnabled
                                          ? AppColors.textPrimary
                                          : AppColors.textMuted,
                                    ),
                                  ),
                                ),

                                // Time Range Chip
                                if (isEnabled)
                                  InkWell(
                                    key: Key('avail_range_$index'),
                                    onTap: () => _cycleTimeRange(index),
                                    borderRadius: BorderRadius.circular(
                                        AppRadius.chip),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondarySurface,
                                        borderRadius: BorderRadius.circular(
                                            AppRadius.chip),
                                        border: Border.all(
                                            color: AppColors.primary),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _timeRanges[rangeIndex],
                                            style:
                                                AppTextStyles.caption.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.autorenew,
                                            size: 13,
                                            color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.circular(
                                          AppRadius.chip),
                                      border:
                                          Border.all(color: AppColors.border),
                                    ),
                                    child: Text(
                                      l10n.wcalDayOff,
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textMuted,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Section 2: Time Off / Nghỉ đột xuất
                    Text(
                      l10n.wavailTimeOffSection,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.wavailTimeOffDesc,
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Time off chips strip
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildTimeOffChip('T7', '26/04'),
                        _buildTimeOffChip('CN', '27/04'),
                        _buildTimeOffChip('T2', '28/04'),
                        _buildTimeOffChip('T3', '29/04'),
                        _buildTimeOffChip('T4', '30/04'),
                        _buildTimeOffChip('T5', '01/05'),
                        _buildTimeOffChip('T6', '02/05'),
                      ],
                    ),

                    // Warning banner if 26/04 is selected
                    if (hasWarrantyWarning) ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.08),
                          borderRadius:
                              BorderRadius.circular(AppRadius.control),
                          border: Border.all(
                            color: AppColors.error.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              color: AppColors.error,
                              size: 20,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.wavailTimeOffWarn,
                                style: AppTextStyles.bodySm.copyWith(
                                  color: AppColors.error,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                key: const Key('save_availability_button'),
                label: l10n.wavailSaveCta,
                onPressed: _saveSchedule,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeOffChip(String dayName, String date) {
    final isSelected = _timeOffDays.contains(date);

    return InkWell(
      key: Key('timeoff_chip_$date'),
      onTap: () => _toggleTimeOff(date),
      borderRadius: BorderRadius.circular(AppRadius.chip),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.error.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(
            color: isSelected ? AppColors.error : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dayName,
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.error : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              date,
              style: AppTextStyles.bodySm.copyWith(
                fontWeight: FontWeight.w800,
                color: isSelected ? AppColors.error : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
