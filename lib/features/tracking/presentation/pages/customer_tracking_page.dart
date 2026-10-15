import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_status_chip.dart';
import 'package:vstech_home_services/features/tracking/domain/entities/worker_position.dart';
import 'package:vstech_home_services/features/tracking/presentation/bloc/customer_tracking_cubit.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/tracking_map_widget.dart';

/// Customer's job tracking (Concept 02: Cells 43, 45, 47, 49), driven by the booking status:
/// ACCEPTED → the worker is on the way (live position over `/ws/tracking/customer`, straight-line
/// distance to the profile's default address), IN_PROGRESS → working, COMPLETED → sign-off. The API
/// has no "arrived" status, ETA, or worker name, so those mock parts are gone.
class CustomerTrackingPage extends StatelessWidget {
  const CustomerTrackingPage({required this.bookingId, super.key});

  final String bookingId;

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
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.trackingTitle,
              style: AppTextStyles.headlineSmall.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              l10n.trackingOrderCode(bookingId),
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: BlocBuilder<CustomerTrackingCubit, CustomerTrackingState>(
        builder: (context, state) => switch (state) {
          CustomerTrackingLoadingState() => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          CustomerTrackingErrorState(:final failure) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Align(
              alignment: Alignment.topCenter,
              child: ErrorRetryView(
                message: l10n.failureMessage(failure),
                onRetry: () => unawaited(
                  context.read<CustomerTrackingCubit>().load(bookingId),
                ),
              ),
            ),
          ),
          CustomerTrackingLoadedState() => _Body(
            state: state,
            bookingId: bookingId,
          ),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state, required this.bookingId});

  final CustomerTrackingLoadedState state;
  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<CustomerTrackingCubit>();
    final stage = state.stage;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => cubit.load(bookingId),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _StageHeader(state: state),
          if (stage.isTrackable) ...[
            const SizedBox(height: AppSpacing.sm),
            _ConnectionRow(
              status: state.connection,
              rejected: state.errorCode != null,
              onReconnect: () => unawaited(cubit.reconnect()),
            ),
          ],
          if (state.errorCode != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _Notice(
              key: const Key('tracking_rejected'),
              icon: Icons.error_outline_rounded,
              color: AppColors.error,
              text: state.errorCode!.isEmpty
                  ? l10n.trackingRejected
                  : l10n.failureMessage(
                      Failure(
                        kind: NetworkErrorKind.server,
                        errorCode: state.errorCode,
                      ),
                    ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          if (stage == TrackingStage.enRoute) ...[
            TrackingMapWidget(
              height: 220,
              workerEtaText: _distanceLabel(context, state.distanceMeters),
              destinationLabel: state.booking.addressDetail,
            ),
            const SizedBox(height: AppSpacing.md),
            _PositionCard(state: state),
          ],
          if (stage == TrackingStage.working) ...[
            _Notice(
              icon: Icons.handyman_outlined,
              color: AppColors.textSecondary,
              text: l10n.trackingWorkingNotice,
            ),
            if (state.position != null) ...[
              const SizedBox(height: AppSpacing.sm),
              _UpdatedAt(position: state.position!),
            ],
          ],
          if (stage == TrackingStage.awaitingSignoff)
            _Notice(
              icon: Icons.task_alt_rounded,
              color: AppColors.successDark,
              text: l10n.trackingSignoffBody,
            ),
          if (stage == TrackingStage.inactive)
            _Notice(
              icon: Icons.info_outline_rounded,
              color: AppColors.textSecondary,
              text: l10n.trackingNotActive,
            ),
          const SizedBox(height: AppSpacing.lg),
          if (stage.isTrackable) _WorkerCard(bookingId: bookingId),
          if (stage == TrackingStage.awaitingSignoff)
            AppButton.primary(
              key: const Key('tracking_signoff_button'),
              label: l10n.trackingProceedToInspection,
              icon: Icons.fact_check_outlined,
              onPressed: () => unawaited(
                context.push('${AppRoutes.inspectionSignoff}?code=$bookingId'),
              ),
            ),
        ],
      ),
    );
  }

  static String? _distanceLabel(BuildContext context, double? meters) {
    if (meters == null) return null;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    if (meters < 1000) {
      return l10n.trackingMeters(
        NumberFormat.decimalPattern(locale).format((meters / 10).round() * 10),
      );
    }
    return l10n.trackingKilometers(
      NumberFormat.decimalPatternDigits(
        locale: locale,
        decimalDigits: 1,
      ).format(meters / 1000),
    );
  }
}

/// Stage of the job as Icon + Label + Color, plus the booking status chip.
class _StageHeader extends StatelessWidget {
  const _StageHeader({required this.state});

  final CustomerTrackingLoadedState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (IconData icon, Color color, String? label) = switch (state.stage) {
      TrackingStage.enRoute => (
        Icons.two_wheeler_rounded,
        AppColors.primaryPressed,
        l10n.trackingStageEnRoute,
      ),
      TrackingStage.working => (
        Icons.handyman_outlined,
        AppColors.primaryPressed,
        l10n.trackingStageExecuting,
      ),
      TrackingStage.awaitingSignoff => (
        Icons.task_alt_rounded,
        AppColors.successDark,
        l10n.trackingStageSignoff,
      ),
      TrackingStage.inactive => (
        Icons.info_outline_rounded,
        AppColors.textSecondary,
        null,
      ),
    };
    return Row(
      children: [
        if (label != null) ...[
          Icon(icon, size: 24, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              key: Key('tracking_stage_${state.stage.name}'),
              style: AppTextStyles.headlineSmall.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ] else
          const Spacer(),
        BookingStatusChip(status: state.booking.status),
      ],
    );
  }
}

class _PositionCard extends StatelessWidget {
  const _PositionCard({required this.state});

  final CustomerTrackingLoadedState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final position = state.position;
    final distance = _Body._distanceLabel(context, state.distanceMeters);
    return Container(
      key: const Key('tracking_position_card'),
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
                Icons.near_me_outlined,
                size: 22,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  position == null
                      ? l10n.trackingWaitingGps
                      : distance == null
                      ? l10n.trackingStageEnRoute
                      : l10n.trackingDistanceAway(distance),
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          if (position != null) ...[
            const SizedBox(height: AppSpacing.xs),
            _UpdatedAt(position: position),
          ],
          if (distance != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.trackingDistanceNote,
              style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
            ),
          ],
        ],
      ),
    );
  }
}

class _UpdatedAt extends StatelessWidget {
  const _UpdatedAt({required this.position});

  final WorkerPosition position;

  @override
  Widget build(BuildContext context) {
    final at = position.updatedAt?.toLocal();
    if (at == null) return const SizedBox.shrink();
    return Text(
      context.l10n.trackingUpdatedAt(DateFormat('HH:mm:ss').format(at)),
      key: const Key('tracking_updated_at'),
      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
    );
  }
}

/// Live / connecting / offline — always Icon + Label + Color.
class _ConnectionRow extends StatelessWidget {
  const _ConnectionRow({
    required this.status,
    required this.rejected,
    required this.onReconnect,
  });

  final TrackingConnectionStatus status;
  final bool rejected;
  final VoidCallback onReconnect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (IconData icon, Color color, String label) = switch (status) {
      TrackingConnectionStatus.live => (
        Icons.wifi_rounded,
        AppColors.successDark,
        l10n.chatConnLive,
      ),
      TrackingConnectionStatus.connecting ||
      TrackingConnectionStatus.reconnecting => (
        Icons.sync_rounded,
        AppColors.textSecondary,
        l10n.chatConnConnecting,
      ),
      TrackingConnectionStatus.offline => (
        Icons.wifi_off_rounded,
        AppColors.error,
        l10n.trackingConnOffline,
      ),
    };
    return Row(
      key: Key('tracking_connection_${status.name}'),
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (status == TrackingConnectionStatus.offline)
          AppSecondaryButton(
            key: const Key('tracking_reconnect'),
            label: l10n.chatReconnect,
            icon: Icons.refresh_rounded,
            onPressed: onReconnect,
          ),
      ],
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({
    required this.icon,
    required this.color,
    required this.text,
    super.key,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.control),
      border: Border.all(
        color: color == AppColors.textSecondary ? AppColors.border : color,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: color),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

/// The assigned worker: the API gives no name or rating, so only the role, with masked call and chat.
class _WorkerCard extends StatelessWidget {
  const _WorkerCard({required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
                Icons.person_outline_rounded,
                size: 24,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.chatPeerWorker,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppSecondaryButton(
                  key: const Key('tracking_call_button'),
                  label: l10n.trackingMaskedCall,
                  icon: Icons.call_outlined,
                  isFullWidth: true,
                  onPressed: () => unawaited(
                    context.push(
                      AppRoutes.voipCallLocation(
                        bookingId: bookingId,
                        isWorker: false,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppSecondaryButton(
                  key: const Key('tracking_chat_button'),
                  label: l10n.trackingChat,
                  icon: Icons.chat_bubble_outline_rounded,
                  isFullWidth: true,
                  onPressed: () => unawaited(
                    context.push(
                      AppRoutes.chatLocation(
                        bookingId: bookingId,
                        isWorker: false,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
