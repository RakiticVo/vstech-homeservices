import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/app_text_field.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/quote_form_cubit.dart';

/// Worker creates an extra-cost quote (design Cell 132, the variant without photos — there is no
/// upload API yet): 1–10 line items, the original estimate with the 1.5× cap, a total pinned above
/// the send button. Pops with `true` once the server accepted the quote.
class WorkerQuotePage extends StatefulWidget {
  const WorkerQuotePage({required this.bookingId, super.key});

  final String bookingId;

  @override
  State<WorkerQuotePage> createState() => _WorkerQuotePageState();
}

class _WorkerQuotePageState extends State<WorkerQuotePage> {
  /// Text fields per draft line id, so removing a line keeps the others' text.
  final Map<int, (TextEditingController, TextEditingController)> _fields = {};

  @override
  void dispose() {
    for (final (name, amount) in _fields.values) {
      name.dispose();
      amount.dispose();
    }
    super.dispose();
  }

  (TextEditingController, TextEditingController) _fieldsFor(int lineId) =>
      _fields.putIfAbsent(
        lineId,
        () => (TextEditingController(), TextEditingController()),
      );

  void _onState(BuildContext context, QuoteFormState state) {
    if (state is! QuoteFormEditingState) return;
    if (state.submitted != null) {
      context.pop(true);
      return;
    }
    if (state.failure case final failure?) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(context.l10n.failureMessage(failure))),
        );
    }
  }

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
        titleSpacing: 0,
        title: BlocBuilder<QuoteFormCubit, QuoteFormState>(
          buildWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType,
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.quoteTitle,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              if (state is QuoteFormEditingState)
                Text(
                  state.serviceName == null
                      ? l10n.chatOrderLabel(state.bookingId)
                      : l10n.quoteSubtitle(state.bookingId, state.serviceName!),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: BlocConsumer<QuoteFormCubit, QuoteFormState>(
        listener: _onState,
        builder: (context, state) => switch (state) {
          QuoteFormLoadingState() => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          QuoteFormLoadErrorState(:final failure) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Align(
              alignment: Alignment.topCenter,
              child: ErrorRetryView(
                message: l10n.failureMessage(failure),
                onRetry: () => unawaited(
                  context.read<QuoteFormCubit>().load(widget.bookingId),
                ),
              ),
            ),
          ),
          QuoteFormEditingState() => _Form(state: state, fieldsFor: _fieldsFor),
        },
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({required this.state, required this.fieldsFor});

  final QuoteFormEditingState state;
  final (TextEditingController, TextEditingController) Function(int lineId)
  fieldsFor;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<QuoteFormCubit>();
    final locked = state.isSending;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              if (state.estimatedPrice != null) ...[
                _EstimateCard(estimate: state.estimatedPrice!),
                const SizedBox(height: AppSpacing.md),
              ],
              for (final (index, line) in state.lines.indexed) ...[
                _LineCard(
                  key: Key('quote_line_${line.id}'),
                  index: index + 1,
                  line: line,
                  fields: fieldsFor(line.id),
                  showErrors: state.showErrors,
                  enabled: !locked,
                  canRemove: state.lines.length > 1,
                  onName: (value) => cubit.updateName(line.id, value),
                  onAmount: (value) => cubit.updateAmount(line.id, value),
                  onRemove: () => cubit.removeLine(line.id),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              AppSecondaryButton(
                key: const Key('quote_add_line'),
                label: state.canAddLine
                    ? l10n.quoteAddItem
                    : l10n.quoteMaxItems,
                icon: Icons.add_rounded,
                isFullWidth: true,
                onPressed: state.canAddLine && !locked ? cubit.addLine : null,
              ),
            ],
          ),
        ),
        _TotalBar(state: state, onSubmit: () => unawaited(cubit.submit())),
      ],
    );
  }
}

class _EstimateCard extends StatelessWidget {
  const _EstimateCard({required this.estimate});

  final num estimate;

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
              Expanded(
                child: Text(
                  l10n.quoteEstimateLabel,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Text(
                MoneyFormatter.format(estimate),
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  l10n.quoteCapNote,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
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

class _LineCard extends StatelessWidget {
  const _LineCard({
    required this.index,
    required this.line,
    required this.fields,
    required this.showErrors,
    required this.enabled,
    required this.canRemove,
    required this.onName,
    required this.onAmount,
    required this.onRemove,
    super.key,
  });

  final int index;
  final QuoteDraftLine line;
  final (TextEditingController, TextEditingController) fields;
  final bool showErrors;
  final bool enabled;
  final bool canRemove;
  final ValueChanged<String> onName;
  final ValueChanged<String> onAmount;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (nameController, amountController) = fields;
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
          Text(
            l10n.quoteItemTitle(index),
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            key: Key('quote_line_name_${line.id}'),
            label: l10n.quoteItemName,
            hintText: l10n.quoteItemNameHint,
            controller: nameController,
            enabled: enabled,
            textInputAction: TextInputAction.next,
            errorText: showErrors && !line.hasName ? l10n.quoteErrorName : null,
            onChanged: onName,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            key: Key('quote_line_amount_${line.id}'),
            label: l10n.quoteItemAmount,
            controller: amountController,
            enabled: enabled,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            suffixText: 'đ',
            errorText: showErrors && !line.hasValidAmount
                ? l10n.quoteErrorAmount
                : null,
            onChanged: onAmount,
          ),
          if (canRemove) ...[
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: AppSecondaryButton(
                key: Key('quote_line_remove_${line.id}'),
                label: l10n.quoteRemoveItem,
                icon: Icons.delete_outline_rounded,
                textColor: AppColors.error,
                onPressed: enabled ? onRemove : null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TotalBar extends StatelessWidget {
  const _TotalBar({required this.state, required this.onSubmit});

  final QuoteFormEditingState state;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.exceedsCap)
              Container(
                key: const Key('quote_cap_error'),
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.control),
                  border: Border.all(color: AppColors.error),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 20,
                      color: AppColors.error,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        l10n.quoteErrorCap(
                          MoneyFormatter.format(state.orderTotal),
                          MoneyFormatter.format(state.cap!),
                        ),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.quoteTotalLabel,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        l10n.quoteTotalNote,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  MoneyFormatter.format(state.total),
                  key: const Key('quote_total'),
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton.primary(
              key: const Key('quote_submit'),
              label: l10n.quoteSubmit,
              icon: Icons.send_rounded,
              isLoading: state.isSending,
              onPressed: state.hasInput && !state.isSending ? onSubmit : null,
            ),
          ],
        ),
      ),
    );
  }
}
