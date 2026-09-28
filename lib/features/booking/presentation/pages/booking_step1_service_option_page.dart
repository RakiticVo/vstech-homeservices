import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/addon_option_tile.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_step_indicator.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/service_option_selector.dart';

/// Step 1 of Customer Booking: Select apartment scope and optional add-ons.
class BookingStep1ServiceOptionPage extends StatefulWidget {
  const BookingStep1ServiceOptionPage({super.key});

  @override
  State<BookingStep1ServiceOptionPage> createState() => _BookingStep1ServiceOptionPageState();
}

class _BookingStep1ServiceOptionPageState extends State<BookingStep1ServiceOptionPage> {
  String _selectedScopeId = 'small';
  int _basePrice = 350000;

  final Set<String> _selectedAddons = {'trash'};

  int get _addonsTotal {
    var total = 0;
    if (_selectedAddons.contains('trash')) total += 30000;
    if (_selectedAddons.contains('disinfect')) total += 50000;
    if (_selectedAddons.contains('glass')) total += 40000;
    return total;
  }

  int get _totalPrice => _basePrice + _addonsTotal;

  String _formatPrice(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    var count = 0;
    for (var i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }
    return '${buffer.toString().split('').reversed.join()}đ';
  }

  void _onContinue() {
    final addonsParam = _selectedAddons.join(',');
    unawaited(
      context.push(
        '${AppRoutes.bookingStep2}?scope=$_selectedScopeId&basePrice=$_basePrice&addons=$addonsParam&addonsPrice=$_addonsTotal',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final addons = [
      AddonItem(
        id: 'trash',
        icon: Icons.delete_sweep_outlined,
        title: context.l10n.bookingAddonTrash,
        desc: context.l10n.bookingAddonTrashDesc,
        price: '+ 30.000đ',
        priceValue: 30000,
      ),
      AddonItem(
        id: 'disinfect',
        icon: Icons.sanitizer_outlined,
        title: context.l10n.bookingAddonDisinfect,
        desc: context.l10n.bookingAddonDisinfectDesc,
        price: '+ 50.000đ',
        priceValue: 50000,
      ),
      AddonItem(
        id: 'glass',
        icon: Icons.window_outlined,
        title: context.l10n.bookingAddonGlass,
        desc: context.l10n.bookingAddonGlassDesc,
        price: '+ 40.000đ',
        priceValue: 40000,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BookingStepIndicator(
        currentStep: 1,
        stepTitle: context.l10n.bookingStep1Title,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  // Scope selector section
                  Text(
                    context.l10n.bookingSelectScope,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ServiceOptionSelector(
                    selectedScopeId: _selectedScopeId,
                    onScopeSelected: (option) {
                      setState(() {
                        _selectedScopeId = option.id;
                        _basePrice = option.priceValue;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Add-ons section
                  Text(
                    context.l10n.bookingAddonsTitle,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...addons.map((addon) {
                    final isChecked = _selectedAddons.contains(addon.id);
                    return AddonOptionTile(
                      addon: addon,
                      isSelected: isChecked,
                      onChanged: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedAddons.add(addon.id);
                          } else {
                            _selectedAddons.remove(addon.id);
                          }
                        });
                      },
                    );
                  }),
                ],
              ),
            ),

            // Pinned bottom action bar
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          context.l10n.bookingEstimatedPreview,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      Text(
                        _formatPrice(_totalPrice),
                        style: AppTextStyles.headlineMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.control),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        context.l10n.bookingContinueToSchedule,
                        style: AppTextStyles.buttonText.copyWith(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
