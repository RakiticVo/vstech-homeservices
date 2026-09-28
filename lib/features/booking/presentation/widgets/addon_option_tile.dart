import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

class AddonItem {
  const AddonItem({
    required this.id,
    required this.icon,
    required this.title,
    required this.desc,
    required this.price,
    required this.priceValue,
  });

  final String id;
  final IconData icon;
  final String title;
  final String desc;
  final String price;
  final int priceValue;
}

/// Checkbox tile for additional booking add-ons.
class AddonOptionTile extends StatelessWidget {
  const AddonOptionTile({
    required this.addon,
    required this.isSelected,
    required this.onChanged,
    super.key,
  });

  final AddonItem addon;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: GestureDetector(
        onTap: () => onChanged(!isSelected),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondarySurface : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadius.control),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Icon(
                  addon.icon,
                  size: 20,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addon.title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      addon.desc,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    addon.price,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Checkbox(
                    value: isSelected,
                    onChanged: (val) => onChanged(val ?? false),
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
