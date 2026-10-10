import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/app_text_field.dart';
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_step_indicator.dart';

/// Step 2 of Customer Booking: date + time slot (→ `scheduledTime`, must be in the future), work
/// address (→ `addressDetail`, prefilled from the profile), its coordinates (→ `locationLat/Lng`,
/// from the profile or the device GPS) and optional notes for the worker.
class BookingStep2ScheduleAddressPage extends StatefulWidget {
  const BookingStep2ScheduleAddressPage({@visibleForTesting this.now, super.key});

  /// Clock override for tests.
  final DateTime Function()? now;

  /// Start hour of each 2-hour arrival window.
  static const List<int> slotStartHours = [8, 10, 14, 16];

  @override
  State<BookingStep2ScheduleAddressPage> createState() => _BookingStep2ScheduleAddressPageState();
}

class _BookingStep2ScheduleAddressPageState extends State<BookingStep2ScheduleAddressPage> {
  late final DateTime _today;
  int _selectedDayOffset = 0; // 0: today, 1: tomorrow
  int? _selectedSlotHour;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _addressError;

  DateTime _now() => (widget.now ?? DateTime.now)();

  @override
  void initState() {
    super.initState();
    final now = _now();
    _today = DateTime(now.year, now.month, now.day);
    final draft = context.read<BookingFlowBloc>().state.draft;
    _addressController.text = draft.address;
    _notesController.text = draft.notes;
    final scheduled = draft.scheduledTime?.toLocal();
    if (scheduled != null && scheduled.isAfter(now)) {
      _selectedDayOffset = DateTime(scheduled.year, scheduled.month, scheduled.day).difference(_today).inDays.clamp(0, 1);
      _selectedSlotHour = scheduled.hour;
    }
    _selectedDayOffset = _firstSelectableSlot(_selectedDayOffset) == null ? 1 : _selectedDayOffset;
    _selectedSlotHour ??= _firstSelectableSlot(_selectedDayOffset);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  DateTime _slotStart(int dayOffset, int hour) =>
      DateTime(_today.year, _today.month, _today.day + dayOffset, hour);

  bool _isSelectable(int dayOffset, int hour) => _slotStart(dayOffset, hour).isAfter(_now());

  int? _firstSelectableSlot(int dayOffset) {
    for (final hour in BookingStep2ScheduleAddressPage.slotStartHours) {
      if (_isSelectable(dayOffset, hour)) return hour;
    }
    return null;
  }

  void _selectDay(int offset) {
    setState(() {
      _selectedDayOffset = offset;
      final slot = _selectedSlotHour;
      if (slot == null || !_isSelectable(offset, slot)) _selectedSlotHour = _firstSelectableSlot(offset);
    });
  }

  void _onContinue() {
    final address = _addressController.text.trim();
    setState(() => _addressError = address.isEmpty ? context.l10n.errorFieldRequired : null);
    final slot = _selectedSlotHour;
    if (_addressError != null || slot == null) return;
    FocusScope.of(context).unfocus();
    context.read<BookingFlowBloc>().add(
      BookingScheduleSubmittedEvent(
        scheduledTime: _slotStart(_selectedDayOffset, slot),
        address: address,
        notes: _notesController.text,
      ),
    );
  }

  void _onStateChanged(BuildContext context, BookingFlowState state) {
    final message = switch (state) {
      BookingFlowLocationFailedState(reason: LocationFailure.permissionDenied) => context.l10n.bookingLocationDenied,
      BookingFlowLocationFailedState(reason: LocationFailure.serviceDisabled) => context.l10n.bookingLocationServiceOff,
      BookingFlowLocationFailedState() => context.l10n.bookingLocationUnavailable,
      _ => null,
    };
    if (message != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }
    if (state is BookingFlowScheduledState) unawaited(context.push(AppRoutes.bookingStep3));
  }

  String _slotLabel(int hour) => '${hour.toString().padLeft(2, '0')}:00 - ${(hour + 2).toString().padLeft(2, '0')}:00';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BookingFlowBloc>().state;
    final draft = state.draft;
    final hasLocation = draft.location != null;
    final estimate = draft.estimate;
    final dayFormat = DateFormat('dd/MM');

    return BlocListener<BookingFlowBloc, BookingFlowState>(
      listener: _onStateChanged,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: BookingStepIndicator(currentStep: 2, stepTitle: context.l10n.bookingStep2Title),
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
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        for (final offset in const [0, 1]) ...[
                          if (offset > 0) const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: _DateChoiceChip(
                              key: Key('booking_day_$offset'),
                              title: offset == 0 ? context.l10n.bookingScheduleToday : context.l10n.bookingScheduleTomorrow,
                              subtitle: dayFormat.format(_slotStart(offset, 0)),
                              isSelected: _selectedDayOffset == offset,
                              isEnabled: _firstSelectableSlot(offset) != null,
                              onTap: () => _selectDay(offset),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Time Slots Section
                    Text(
                      context.l10n.bookingScheduleTimeSlot,
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final hour in BookingStep2ScheduleAddressPage.slotStartHours)
                          ChoiceChip(
                            key: Key('booking_slot_$hour'),
                            label: Text(_slotLabel(hour)),
                            selected: hour == _selectedSlotHour,
                            onSelected: _isSelectable(_selectedDayOffset, hour)
                                ? (selected) {
                                    if (selected) setState(() => _selectedSlotHour = hour);
                                  }
                                : null,
                            selectedColor: AppColors.secondarySurface,
                            backgroundColor: AppColors.surface,
                            disabledColor: AppColors.background,
                            side: BorderSide(color: hour == _selectedSlotHour ? AppColors.primary : AppColors.border),
                            labelStyle: AppTextStyles.bodyMedium.copyWith(
                              color: !_isSelectable(_selectedDayOffset, hour)
                                  ? AppColors.textMuted
                                  : hour == _selectedSlotHour
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                              fontWeight: hour == _selectedSlotHour ? FontWeight.w700 : FontWeight.w500,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.control)),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Work address (addressDetail)
                    AppTextField(
                      key: const Key('booking_address_field'),
                      controller: _addressController,
                      label: context.l10n.bookingWorkAddress,
                      hintText: context.l10n.bookingAddressHint,
                      errorText: _addressError,
                      maxLines: 2,
                      prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.textMuted, size: 20),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Coordinates (locationLat/Lng) status: Icon + Label + Color
                    _LocationStatus(
                      hasLocation: hasLocation,
                      isLocating: state is BookingFlowLocatingState,
                      onUseCurrentLocation: () =>
                          context.read<BookingFlowBloc>().add(const BookingLocationRequestedEvent()),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Notes for worker (appended to the description sent to the API)
                    AppTextField(
                      controller: _notesController,
                      label: context.l10n.bookingNotesLabel,
                      hintText: context.l10n.bookingNotesHint,
                      maxLines: 2,
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
                    if (estimate != null) ...[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              context.l10n.bookingEstimatedPreview,
                              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                            ),
                          ),
                          Text(
                            MoneyFormatter.format(estimate.totalEstimated),
                            style: AppTextStyles.headlineMedium.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                    AppButton.primary(
                      key: const Key('booking_schedule_continue_button'),
                      label: context.l10n.bookingContinueToConfirm,
                      onPressed: hasLocation && _selectedSlotHour != null ? _onContinue : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationStatus extends StatelessWidget {
  const _LocationStatus({required this.hasLocation, required this.isLocating, required this.onUseCurrentLocation});

  final bool hasLocation;
  final bool isLocating;
  final VoidCallback onUseCurrentLocation;

  @override
  Widget build(BuildContext context) {
    final color = hasLocation ? AppColors.successDark : AppColors.warning;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(hasLocation ? Icons.check_circle_outline : Icons.error_outline, size: 18, color: color),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  hasLocation ? context.l10n.bookingLocationReady : context.l10n.bookingLocationMissing,
                  key: const Key('booking_location_status'),
                  style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          if (isLocating)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
              ),
            )
          else
            AppSecondaryButton(
              key: const Key('booking_use_location_button'),
              label: context.l10n.bookingUseCurrentLocation,
              icon: Icons.my_location_outlined,
              onPressed: onUseCurrentLocation,
            ),
        ],
      ),
    );
  }
}

class _DateChoiceChip extends StatelessWidget {
  const _DateChoiceChip({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = !isEnabled
        ? AppColors.textMuted
        : isSelected
        ? AppColors.primary
        : AppColors.textPrimary;
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: isSelected ? 1.5 : 1.0),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: foreground,
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
