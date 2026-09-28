import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Worker operating zone & radius configuration screen (Cell 125 `wzone`).
class WorkerWorkZonePage extends StatefulWidget {
  const WorkerWorkZonePage({super.key});

  @override
  State<WorkerWorkZonePage> createState() => _WorkerWorkZonePageState();
}

class _WorkerWorkZonePageState extends State<WorkerWorkZonePage> {
  int _selectedRadius = 5; // 3, 5, 8, 12 km

  final List<int> _radiusStops = [3, 5, 8, 12];

  final List<String> _allDistricts = [
    'Quận 1',
    'Quận 2 (Thủ Đức)',
    'Quận 3',
    'Quận 7',
    'Bình Thạnh',
    'Phú Nhuận',
    'Gò Vấp',
    'Tân Bình',
    'Tân Phú',
  ];

  late Set<String> _selectedDistricts;

  @override
  void initState() {
    super.initState();
    _selectedDistricts = {
      'Quận 1',
      'Quận 2 (Thủ Đức)',
      'Bình Thạnh',
      'Phú Nhuận',
    };
  }

  void _toggleDistrict(String district) {
    setState(() {
      if (_selectedDistricts.contains(district)) {
        if (_selectedDistricts.length > 1) {
          _selectedDistricts.remove(district);
        }
      } else {
        _selectedDistricts.add(district);
      }
    });
  }

  void _saveZone() {
    final l10n = context.l10n;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.wzoneSavedSuccess),
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
          l10n.wzoneTitle,
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
                    // Visual Coverage Map Radar Illustration
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Concentric radius circles
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withValues(alpha: 0.08),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                          // Center worker pin
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.surface,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: AppColors.onPrimary,
                              size: 16,
                            ),
                          ),
                          // Radius label badge
                          Positioned(
                            bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.chip),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(
                                'Bán kính hoạt động: $_selectedRadius km',
                                style: AppTextStyles.caption.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Radius Stops Section
                    Text(
                      l10n.wzoneRadiusTitle,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.wzoneRadiusNote,
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Radius Stops Buttons
                    Row(
                      children: _radiusStops.map((km) {
                        final isSelected = km == _selectedRadius;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              key: Key('radius_chip_$km'),
                              onTap: () {
                                setState(() {
                                  _selectedRadius = km;
                                });
                              },
                              borderRadius:
                                  BorderRadius.circular(AppRadius.control),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.secondarySurface
                                      : AppColors.surface,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.control),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.border,
                                    width: isSelected ? 1.5 : 1.0,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '$km km',
                                  style: AppTextStyles.bodyMd.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w800
                                        : FontWeight.w600,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Districts Section
                    Text(
                      l10n.wzoneDistrictsTitle,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.wzoneDistrictsNote,
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Districts wrap chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _allDistricts.map((district) {
                        final isSelected =
                            _selectedDistricts.contains(district);

                        return FilterChip(
                          key: Key('district_chip_$district'),
                          selected: isSelected,
                          showCheckmark: true,
                          checkmarkColor: AppColors.primary,
                          label: Text(district),
                          labelStyle: AppTextStyles.bodySm.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                          backgroundColor: AppColors.surface,
                          selectedColor: AppColors.secondarySurface,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.control),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          onSelected: (_) => _toggleDistrict(district),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Save CTA
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: AppButton(
                key: const Key('save_zone_button'),
                label: l10n.wzoneSaveCta,
                onPressed: _saveZone,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
