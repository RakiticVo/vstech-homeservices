import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notification_settings_cubit.dart';

/// Notification settings for customers (Cell 65) and workers: one switch per category the API
/// supports (system / booking / promo) and a single Save CTA, enabled only after a change.
class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          l10n.notifSettingsTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: BlocConsumer<NotificationSettingsCubit, NotificationSettingsState>(
        listenWhen: (previous, current) =>
            current is NotificationSettingsLoadedState &&
            (previous is! NotificationSettingsLoadedState ||
                previous.status != current.status) &&
            (current.status == SettingsSaveStatus.saved ||
                current.status == SettingsSaveStatus.failed),
        listener: (context, state) {
          final loaded = state as NotificationSettingsLoadedState;
          final message = loaded.status == SettingsSaveStatus.saved
              ? l10n.notifSettingsSaved
              : l10n.failureMessage(loaded.failure!);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        },
        builder: (context, state) => switch (state) {
          NotificationSettingsLoadingState() => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          NotificationSettingsErrorState(:final failure) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Align(
              alignment: Alignment.topCenter,
              child: ErrorRetryView(
                message: l10n.failureMessage(failure),
                onRetry: () =>
                    unawaited(context.read<NotificationSettingsCubit>().load()),
              ),
            ),
          ),
          NotificationSettingsLoadedState() => _SettingsForm(state: state),
        },
      ),
    );
  }
}

class _SettingsForm extends StatelessWidget {
  const _SettingsForm({required this.state});

  final NotificationSettingsLoadedState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<NotificationSettingsCubit>();
    final isSaving = state.status == SettingsSaveStatus.saving;
    final rows = [
      (
        NotificationType.booking,
        l10n.notifSettingsBooking,
        l10n.notifSettingsBookingDesc,
        state.draft.bookingEnabled,
      ),
      (
        NotificationType.system,
        l10n.notifSettingsSystem,
        l10n.notifSettingsSystemDesc,
        state.draft.systemEnabled,
      ),
      (
        NotificationType.promo,
        l10n.notifSettingsPromo,
        l10n.notifSettingsPromoDesc,
        state.draft.promoEnabled,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              for (final (index, (type, title, subtitle, value))
                  in rows.indexed) ...[
                if (index > 0)
                  const Divider(height: AppSpacing.lg, color: AppColors.border),
                _SwitchRow(
                  key: Key('notif_settings_${type.name}'),
                  title: title,
                  subtitle: subtitle,
                  value: value,
                  onChanged: isSaving
                      ? null
                      : (enabled) => cubit.toggle(type, enabled: enabled),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton.primary(
          key: const Key('notif_settings_save'),
          label: l10n.notifSettingsSave,
          isLoading: isSaving,
          onPressed: state.isDirty && !isSaving
              ? () => unawaited(cubit.save())
              : null,
        ),
      ],
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: AppColors.primary,
        ),
      ],
    );
  }
}
