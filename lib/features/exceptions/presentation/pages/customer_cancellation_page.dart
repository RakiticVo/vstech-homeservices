import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/features/exceptions/presentation/bloc/booking_action_cubit.dart';
import 'package:vstech_home_services/features/exceptions/presentation/widgets/booking_action_confirm_scaffold.dart';

/// Customer Cancellation Page (Concept 02 — Cell 67 `cancel`).
/// Confirms and sends `POST /bookings/{id}/cancel` (allowed while PENDING/ACCEPTED). Cancellation
/// reasons and the late-cancel fee (Cell 68) are not part of the API yet, so they are not shown.
class CustomerCancellationPage extends StatelessWidget {
  const CustomerCancellationPage({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BookingActionConfirmScaffold(
      title: l10n.cancelTitle,
      orderCode: bookingId,
      icon: Icons.cancel_outlined,
      notice: l10n.cancelPolicyNoteFree,
      confirmLabel: l10n.cancelConfirmBtnFree,
      onConfirm: () => unawaited(context.read<BookingActionCubit>().cancel(bookingId)),
      onDone: (context) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.cancelDoneMessage)));
        context.pop();
      },
    );
  }
}
