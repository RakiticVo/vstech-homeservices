import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/app_text_field.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_step_indicator.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/category_thumbnail.dart';

/// Step 1 of Customer Booking: describe the problem for the chosen category and get the server-side
/// price estimate (`POST /bookings/estimate` — `categoryId` + `description`, both required).
class BookingStep1ServiceOptionPage extends StatefulWidget {
  const BookingStep1ServiceOptionPage({required this.categoryId, super.key});

  final String categoryId;

  @override
  State<BookingStep1ServiceOptionPage> createState() => _BookingStep1ServiceOptionPageState();
}

class _BookingStep1ServiceOptionPageState extends State<BookingStep1ServiceOptionPage> {
  final TextEditingController _descriptionController = TextEditingController();
  String? _descriptionError;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<BookingFlowBloc>();
    if (bloc.state.draft.categoryId != widget.categoryId) {
      bloc.add(BookingFlowStartedEvent(widget.categoryId));
    } else {
      _descriptionController.text = bloc.state.draft.description;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final description = _descriptionController.text.trim();
    setState(() => _descriptionError = description.isEmpty ? context.l10n.errorFieldRequired : null);
    if (_descriptionError != null) return;

    FocusScope.of(context).unfocus();
    final draft = context.read<BookingFlowBloc>().state.draft;
    if (draft.estimate != null && draft.description == description) {
      unawaited(context.push(AppRoutes.bookingStep2));
      return;
    }
    context.read<BookingFlowBloc>().add(BookingEstimateRequestedEvent(description));
  }

  void _onStateChanged(BuildContext context, BookingFlowState state) {
    switch (state) {
      case BookingFlowEstimatedState():
        unawaited(context.push(AppRoutes.bookingStep2));
      case BookingFlowErrorState(:final failure, :final draft) when draft.category != null:
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(context.l10n.failureMessage(failure))));
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BookingFlowBloc>().state;
    final category = state.draft.category;
    final isEstimating = state is BookingFlowEstimatingState;

    return BlocListener<BookingFlowBloc, BookingFlowState>(
      listener: _onStateChanged,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: BookingStepIndicator(currentStep: 1, stepTitle: context.l10n.bookingStep1Title),
        body: SafeArea(
          child: switch (state) {
            BookingFlowErrorState(:final failure) when category == null => Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: ErrorRetryView(
                message: context.l10n.failureMessage(failure),
                onRetry: () => context.read<BookingFlowBloc>().add(BookingFlowStartedEvent(widget.categoryId)),
              ),
            ),
            _ when category == null => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            _ => Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    children: [
                      _CategoryHeader(category: category),
                      const SizedBox(height: AppSpacing.lg),
                      AppTextField(
                        key: const Key('booking_description_field'),
                        controller: _descriptionController,
                        label: context.l10n.bookingDescribeLabel,
                        hintText: context.l10n.bookingDescribeHint,
                        errorText: _descriptionError,
                        maxLines: 4,
                        textInputAction: TextInputAction.newline,
                      ),
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
                  child: AppButton.primary(
                    key: const Key('booking_estimate_button'),
                    label: context.l10n.bookingEstimateCta,
                    isLoading: isEstimating,
                    onPressed: isEstimating ? null : _onContinue,
                  ),
                ),
              ],
            ),
          },
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.category});

  final ServiceCategory category;

  @override
  Widget build(BuildContext context) {
    final basePrice = category.basePrice;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CategoryThumbnail(imageUrl: category.imageUrl, size: 52),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: AppTextStyles.titleLg.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                if (basePrice != null)
                  Text(
                    context.l10n.startingFrom(MoneyFormatter.format(basePrice)),
                    style: AppTextStyles.labelMd.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w700),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
