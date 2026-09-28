import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

class ServiceScopeOption {
  const ServiceScopeOption({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.priceValue,
  });

  final String id;
  final String title;
  final String desc;
  final String price;
  final int priceValue;
}

/// Selector for choosing apartment/room scope and base labour pricing.
/// Complies with Master Spec v9.0: selected card = secondarySurface + primary border + check.
class ServiceOptionSelector extends StatelessWidget {
  const ServiceOptionSelector({
    required this.selectedScopeId,
    required this.onScopeSelected,
    super.key,
  });

  final String selectedScopeId;
  final ValueChanged<ServiceScopeOption> onScopeSelected;

  @override
  Widget build(BuildContext context) {
    final options = [
      ServiceScopeOption(
        id: 'small',
        title: context.l10n.bookingScopeSmall,
        desc: context.l10n.bookingScopeSmallDesc,
        price: '350.000đ',
        priceValue: 350000,
      ),
      ServiceScopeOption(
        id: 'medium',
        title: context.l10n.bookingScopeMedium,
        desc: context.l10n.bookingScopeMediumDesc,
        price: '450.000đ',
        priceValue: 450000,
      ),
      ServiceScopeOption(
        id: 'large',
        title: context.l10n.bookingScopeLarge,
        desc: context.l10n.bookingScopeLargeDesc,
        price: '600.000đ',
        priceValue: 600000,
      ),
    ];

    return Column(
      children: options.map((option) {
        final isSelected = option.id == selectedScopeId;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: GestureDetector(
            onTap: () => onScopeSelected(option),
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
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.textMuted,
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 14,
                            color: AppColors.onPrimary,
                          )
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.title,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          option.desc,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    option.price,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
