import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_text_field.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_step_indicator.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/premises_surcharge_card.dart';

/// Step 2 of Customer Booking: Select schedule date/time, verify address, and choose premises context.
class BookingStep2ScheduleAddressPage extends StatefulWidget {
  const BookingStep2ScheduleAddressPage({
    this.basePrice = 350000,
    this.addonsPrice = 30000,
    this.scopeId = 'small',
    this.addons = 'trash',
    super.key,
  });

  final int basePrice;
  final int addonsPrice;
  final String scopeId;
  final String addons;

  @override
  State<BookingStep2ScheduleAddressPage> createState() => _BookingStep2ScheduleAddressPageState();
}

class _BookingStep2ScheduleAddressPageState extends State<BookingStep2ScheduleAddressPage> {
  int _selectedDateIndex = 0; // 0: Today, 1: Tomorrow
  String _selectedSlot = '14:00 - 16:00';
  String _selectedPremisesId = 'elevator';
  int _premisesSurcharge = 20000;
  int _attachedPhotosCount = 0;

  final TextEditingController _notesController = TextEditingController();

  final List<String> _timeSlots = [
    '08:00 - 10:00',
    '10:00 - 12:00',
    '14:00 - 16:00',
    '16:00 - 18:00',
  ];

  int get _totalPrice => widget.basePrice + widget.addonsPrice + _premisesSurcharge;

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

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final dateStr = _selectedDateIndex == 0 ? 'today' : 'tomorrow';
    unawaited(
      context.push(
        '${AppRoutes.bookingStep3}?basePrice=${widget.basePrice}&addonsPrice=${widget.addonsPrice}&premisesPrice=$_premisesSurcharge&premisesId=$_selectedPremisesId&date=$dateStr&slot=$_selectedSlot',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BookingStepIndicator(
        currentStep: 2,
        stepTitle: context.l10n.bookingStep2Title,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  // Date Picker Section
                  Text(
                    context.l10n.bookingScheduleDate,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: _DateChoiceChip(
                          title: context.l10n.bookingScheduleToday,
                          subtitle: '23/09',
                          isSelected: _selectedDateIndex == 0,
                          onTap: () => setState(() => _selectedDateIndex = 0),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _DateChoiceChip(
                          title: context.l10n.bookingScheduleTomorrow,
                          subtitle: '24/09',
                          isSelected: _selectedDateIndex == 1,
                          onTap: () => setState(() => _selectedDateIndex = 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Time Slots Section
                  Text(
                    context.l10n.bookingScheduleTimeSlot,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: _timeSlots.map((slot) {
                      final isSelected = slot == _selectedSlot;
                      return ChoiceChip(
                        label: Text(slot),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) setState(() => _selectedSlot = slot);
                        },
                        selectedColor: AppColors.secondarySurface,
                        backgroundColor: AppColors.surface,
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                        labelStyle: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.control),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Service Address Section
                  Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 18,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      context.l10n.bookingWorkAddress,
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ),
                              child: Text(
                                context.l10n.bookingChangeAddress,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Căn hộ B12.04, Masteri Thảo Điền, 159 Xa Lộ Hà Nội, P. Thảo Điền, TP. Thủ Đức',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Housing context / Premises surcharge
                  PremisesSurchargeCard(
                    selectedPremisesId: _selectedPremisesId,
                    onSelected: (option) {
                      setState(() {
                        _selectedPremisesId = option.id;
                        _premisesSurcharge = option.surchargeValue;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Notes for worker
                  AppTextField(
                    controller: _notesController,
                    label: context.l10n.bookingNotesLabel,
                    hintText: context.l10n.bookingNotesHint,
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Photo upload attachment
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_attachedPhotosCount < 5) _attachedPhotosCount++;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: _attachedPhotosCount > 0
                            ? AppColors.secondarySurface
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(
                          color: _attachedPhotosCount > 0
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _attachedPhotosCount > 0
                                ? Icons.add_photo_alternate_rounded
                                : Icons.camera_alt_outlined,
                            size: 24,
                            color: _attachedPhotosCount > 0
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              _attachedPhotosCount > 0
                                  ? context.l10n.bookingPhotoAdded(_attachedPhotosCount)
                                  : context.l10n.bookingAttachPhotos,
                              style: AppTextStyles.caption.copyWith(
                                color: _attachedPhotosCount > 0
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                fontWeight: _attachedPhotosCount > 0
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                          if (_attachedPhotosCount > 0)
                            IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              onPressed: () => setState(() => _attachedPhotosCount = 0),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Pinned bottom summary bar
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
                        context.l10n.bookingContinueToConfirm,
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

class _DateChoiceChip extends StatelessWidget {
  const _DateChoiceChip({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTextStyles.caption.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
