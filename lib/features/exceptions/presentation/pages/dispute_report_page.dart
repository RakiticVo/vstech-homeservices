import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/features/exceptions/presentation/bloc/booking_action_cubit.dart';
import 'package:vstech_home_services/features/exceptions/presentation/widgets/booking_action_confirm_scaffold.dart';

/// Dispute Report Page (Concept 02 — Cell 79 `dispute`).
/// Confirms and sends `POST /bookings/{id}/dispute` (only for COMPLETED bookings). The API accepts
/// no issue type, description or photos yet, so those inputs are not shown.
class DisputeReportPage extends StatelessWidget {
  const DisputeReportPage({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BookingActionConfirmScaffold(
      title: l10n.disputeTitle,
      orderCode: bookingId,
      icon: Icons.report_problem_outlined,
      notice: l10n.disputeConfirmNotice,
      confirmLabel: l10n.disputeConfirmBtn,
      onConfirm: () => unawaited(context.read<BookingActionCubit>().dispute(bookingId)),
      onDone: (context) => context.pushReplacement(AppRoutes.orderDisputed),
    );
  }
}
