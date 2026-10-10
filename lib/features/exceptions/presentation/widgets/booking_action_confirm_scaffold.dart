import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/exceptions/presentation/bloc/booking_action_cubit.dart';

/// Shared layout for the cancel / dispute confirmation screens: what will happen, the order code,
/// one primary confirm CTA and a "keep" secondary action. The API takes no reason or photos for
/// either call, so none are collected.
class BookingActionConfirmScaffold extends StatelessWidget {
  const BookingActionConfirmScaffold({
    required this.title,
    required this.orderCode,
    required this.icon,
    required this.notice,
    required this.confirmLabel,
    required this.onConfirm,
    required this.onDone,
    super.key,
  });

  final String title;
  final String orderCode;
  final IconData icon;
  final String notice;
  final String confirmLabel;
  final VoidCallback onConfirm;

  /// Called once the API accepted the action.
  final void Function(BuildContext context) onDone;

  @override
  Widget build(BuildContext context) {
    final isBusy = context.select<BookingActionCubit, bool>((cubit) => cubit.state is BookingActionInProgressState);
    return BlocListener<BookingActionCubit, BookingActionState>(
      listener: (context, state) {
        switch (state) {
          case BookingActionDoneState():
            onDone(context);
          case BookingActionFailedState(:final failure):
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(context.l10n.failureMessage(failure))));
          case BookingActionIdleState() || BookingActionInProgressState():
            break;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
            onPressed: () => context.pop(),
          ),
          title: Text(
            title,
            style: AppTextStyles.headlineSmall.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(icon, color: AppColors.error, size: 24),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  context.l10n.complaintDetailOrderCode('#$orderCode'),
                                  key: const Key('booking_action_order_code'),
                                  style: AppTextStyles.titleLg.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(notice, style: AppTextStyles.bodyMd.copyWith(color: AppColors.textPrimary, height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton.primary(
                      key: const Key('booking_action_confirm_button'),
                      label: confirmLabel,
                      isLoading: isBusy,
                      onPressed: isBusy ? null : onConfirm,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppSecondaryButton(
                      key: const Key('booking_action_keep_button'),
                      label: context.l10n.cancelKeepBookingBtn,
                      isFullWidth: true,
                      onPressed: isBusy ? null : () => context.pop(),
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
