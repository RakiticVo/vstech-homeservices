import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

class PremisesOption {
  const PremisesOption({
    required this.id,
    required this.icon,
    required this.title,
    required this.surchargeText,
    required this.surchargeValue,
  });

  final String id;
  final IconData icon;
  final String title;
  final String surchargeText;
  final int surchargeValue;
}

/// Selector card for housing context and transparent premises surcharge (PRD v2.3).
class PremisesSurchargeCard extends StatelessWidget {
  const PremisesSurchargeCard({
    required this.selectedPremisesId,
    required this.onSelected,
    super.key,
  });

  final String selectedPremisesId;
  final ValueChanged<PremisesOption> onSelected;

  @override
  Widget build(BuildContext context) {
    final options = [
      PremisesOption(
        id: 'ground',
        icon: Icons.home_outlined,
        title: context.l10n.bookingPremisesGround,
        surchargeText: context.l10n.bookingPremisesGroundSurcharge,
        surchargeValue: 0,
      ),
      PremisesOption(
        id: 'elevator',
        icon: Icons.elevator_outlined,
        title: context.l10n.bookingPremisesElevator,
        surchargeText: context.l10n.bookingPremisesElevatorSurcharge,
        surchargeValue: 20000,
      ),
      PremisesOption(
        id: 'stairs',
        icon: Icons.stairs_outlined,
        title: context.l10n.bookingPremisesStairs,
        surchargeText: context.l10n.bookingPremisesStairsSurcharge,
        surchargeValue: 50000,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.apartment_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  context.l10n.bookingPremisesType,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Column(
            children: options.map((option) {
              final isSelected = option.id == selectedPremisesId;

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: GestureDetector(
                  onTap: () => onSelected(option),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.secondarySurface : AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: isSelected ? 1.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          option.icon,
                          size: 20,
                          color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            option.title,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? AppColors.primary : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.12)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(AppRadius.chip),
                          ),
                          child: Text(
                            option.surchargeText,
                            style: AppTextStyles.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isSelected ? AppColors.primary : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
