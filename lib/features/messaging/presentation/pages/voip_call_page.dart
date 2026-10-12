import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/voip_call_cubit.dart';

/// Outgoing call on a booking (`call` — Cells 82, 83). The call is logged through
/// `POST /voip/calls` / `POST /voip/calls/end`; audio is **not** connected yet (no VoIP SDK), which
/// the screen says plainly. Incoming calls are not offered — nothing can deliver them yet.
class VoipCallPage extends StatelessWidget {
  const VoipCallPage({
    required this.bookingId,
    required this.isWorker,
    super.key,
  });

  final String bookingId;
  final bool isWorker;

  static String formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final rest = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$rest';
  }

  void _leave(BuildContext context) {
    if (context.canPop()) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final peer = isWorker ? l10n.chatPeerCustomer : l10n.chatPeerWorker;

    return BlocListener<VoipCallCubit, VoipCallState>(
      listenWhen: (previous, current) => current is VoipCallEndedState,
      listener: (context, state) => _leave(context),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: BlocBuilder<VoipCallCubit, VoipCallState>(
              builder: (context, state) {
                final cubit = context.read<VoipCallCubit>();
                return Column(
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 64,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      peer,
                      style: AppTextStyles.headlineSmall.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.chatOrderLabel(bookingId),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _CallStatus(state: state),
                    const SizedBox(height: AppSpacing.lg),
                    const _SimulatedNotice(),
                    const Spacer(),
                    if (state is VoipCallErrorState)
                      AppButton.primary(
                        key: const Key('call_close_button'),
                        label: l10n.callClose,
                        icon: Icons.close_rounded,
                        onPressed: () => _leave(context),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _CallControl(
                            key: const Key('call_mute_button'),
                            icon: state is VoipCallActiveState && state.isMuted
                                ? Icons.mic_off_rounded
                                : Icons.mic_none_rounded,
                            label: l10n.callMute,
                            isActive:
                                state is VoipCallActiveState && state.isMuted,
                            onTap: state is VoipCallActiveState
                                ? cubit.toggleMute
                                : null,
                          ),
                          _CallControl(
                            key: const Key('call_speaker_button'),
                            icon: Icons.volume_up_outlined,
                            label: l10n.callSpeaker,
                            isActive:
                                state is VoipCallActiveState && state.isSpeaker,
                            onTap: state is VoipCallActiveState
                                ? cubit.toggleSpeaker
                                : null,
                          ),
                          _CallControl(
                            key: const Key('call_end_button'),
                            icon: Icons.call_end_rounded,
                            label: l10n.callEnd,
                            isEnd: true,
                            onTap: () => unawaited(cubit.hangUp()),
                          ),
                        ],
                      ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CallStatus extends StatelessWidget {
  const _CallStatus({required this.state});

  final VoipCallState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return switch (state) {
      VoipCallStartingState() || VoipCallEndedState() => Text(
        l10n.callConnecting,
        style: AppTextStyles.titleLg.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
        ),
      ),
      VoipCallActiveState(:final elapsedSeconds) => Text(
        VoipCallPage.formatDuration(elapsedSeconds),
        key: const Key('call_duration'),
        style: AppTextStyles.titleLg.copyWith(
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
      ),
      VoipCallErrorState(:final failure) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 20,
            color: AppColors.error,
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              l10n.failureMessage(failure),
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    };
  }
}

class _SimulatedNotice extends StatelessWidget {
  const _SimulatedNotice();

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      border: Border.all(color: AppColors.border),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline_rounded,
          size: 20,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            context.l10n.callSimulatedNotice,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Round call control with its label underneath (never icon-only).
class _CallControl extends StatelessWidget {
  const _CallControl({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.isEnd = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isActive;
  final bool isEnd;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color border, Color foreground) = isEnd
        ? (AppColors.error, AppColors.error, AppColors.onPrimary)
        : isActive
        ? (
            AppColors.secondarySurface,
            AppColors.primary,
            AppColors.primaryPressed,
          )
        : (
            AppColors.surface,
            AppColors.border,
            onTap == null ? AppColors.textMuted : AppColors.textSecondary,
          );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: background,
          shape: CircleBorder(side: BorderSide(color: border, width: 1.5)),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: SizedBox.square(
              dimension: 64,
              child: Icon(icon, size: 26, color: foreground),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
