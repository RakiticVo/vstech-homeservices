import 'package:flutter/material.dart';
import 'package:vstech_home_services/app.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// Compact language toggle button (VI / EN) wired to [appLocaleNotifier].
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, currentLocale, _) {
        final isVi = currentLocale.languageCode == 'vi';

        return Container(
          height: 34,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LangSegment(
                label: 'VI',
                isSelected: isVi,
                onTap: () => appLocaleNotifier.value = const Locale('vi'),
              ),
              _LangSegment(
                label: 'EN',
                isSelected: !isVi,
                onTap: () => appLocaleNotifier.value = const Locale('en'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LangSegment extends StatelessWidget {
  const _LangSegment({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: isSelected ? Border.all(color: AppColors.primary) : null,
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
