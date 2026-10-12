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
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/service_checklist_widget.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/working_timer_widget.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/worker_task_cubit.dart';

/// Worker Service Execution Screen (`wwork` — Concept 02: Cell 48).
/// Real-time working timer, interactive 5-step checklist (local), extra-cost quote
/// (`POST /bookings/{id}/quote`) and job completion with the final price
/// (`POST /bookings/{id}/complete`, at most 1.5 × the estimate).
class WorkerExecutingPage extends StatefulWidget {
  const WorkerExecutingPage({required this.bookingId, super.key});

  final String bookingId;

  @override
  State<WorkerExecutingPage> createState() => _WorkerExecutingPageState();
}

class _WorkerExecutingPageState extends State<WorkerExecutingPage> {
  final Set<int> _completedSteps = {0, 1};
  int _currentStep = 2;

  @override
  void initState() {
    super.initState();
    unawaited(context.read<WorkerTaskCubit>().load(widget.bookingId));
  }

  void _onStateChanged(BuildContext context, WorkerTaskState state) {
    final messenger = ScaffoldMessenger.of(context);
    switch (state) {
      case WorkerTaskActionDoneState(action: WorkerTaskAction.quote):
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(context.l10n.workerProposalSent)),
          );
      case WorkerTaskActionDoneState(action: WorkerTaskAction.complete):
        context.go(AppRoutes.workerJobCompletion);
      case WorkerTaskActionFailedState(:final failure):
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(context.l10n.failureMessage(failure))),
          );
      default:
        break;
    }
  }

  /// Digits typed into a money field ("45.000" → 45000), or null if there are none.
  static num? _parseMoney(String text) {
    final digits = text.replaceAll(RegExp('[^0-9]'), '');
    return digits.isEmpty ? null : num.parse(digits);
  }

  void _showCompleteDialog() {
    final task = context.read<WorkerTaskCubit>().state.data;
    if (task == null) return;
    final priceController = TextEditingController(
      text: '${task.suggestedFinalPrice}',
    );
    final estimate = task.booking.estimatedPrice;
    unawaited(
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          title: Text(
            context.l10n.workerFinalPriceTitle,
            style: AppTextStyles.headlineSmall.copyWith(fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (estimate != null)
                Text(
                  context.l10n.workerFinalPriceHint(
                    MoneyFormatter.format(estimate),
                  ),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                key: const Key('worker_final_price_field'),
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: context.l10n.workerFinalPriceLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                context.l10n.cancel,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              key: const Key('worker_final_price_confirm'),
              onPressed: () {
                final price = _parseMoney(priceController.text);
                if (price == null) return;
                Navigator.of(ctx).pop();
                unawaited(context.read<WorkerTaskCubit>().complete(price));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
              child: Text(context.l10n.confirm),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleStep(int index) {
    setState(() {
      if (_completedSteps.contains(index)) {
        _completedSteps.remove(index);
      } else {
        _completedSteps.add(index);
        if (index == _currentStep && _currentStep < 4) {
          _currentStep++;
        }
      }
    });
  }

  void _showExtraCostDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    unawaited(
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          title: Text(
            context.l10n.workerExtraCostDialogTitle,
            style: AppTextStyles.headlineSmall.copyWith(fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.workerExtraCostDesc,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                key: const Key('worker_extra_cost_name'),
                controller: nameController,
                decoration: InputDecoration(
                  labelText: context.l10n.workerItemName,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                key: const Key('worker_extra_cost_price'),
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: context.l10n.workerItemPrice,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                context.l10n.cancel,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              key: const Key('worker_extra_cost_send'),
              onPressed: () {
                final amount = _parseMoney(priceController.text);
                if (nameController.text.trim().isEmpty || amount == null)
                  return;
                Navigator.of(ctx).pop();
                unawaited(
                  context.read<WorkerTaskCubit>().submitQuote([
                    QuoteLine(itemName: nameController.text, amount: amount),
                  ]),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
              child: Text(context.l10n.workerSendProposal),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkerTaskCubit, WorkerTaskState>(
      listener: _onStateChanged,
      child: Scaffold(
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
            context.l10n.workerExecutingTitle,
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
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            // Live Execution Timer
            const WorkingTimerWidget(),

            const SizedBox(height: AppSpacing.lg),

            // Interactive 5-Step Safety Checklist
            ServiceChecklistWidget(
              completedSteps: _completedSteps,
              currentStep: _currentStep,
              isEditable: true,
              onToggleStep: _toggleStep,
            ),

            const SizedBox(height: AppSpacing.lg),

            // Request Extra Material Cost Button
            OutlinedButton.icon(
              onPressed: _showExtraCostDialog,
              icon: const Icon(
                Icons.build_circle_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              label: Text(
                context.l10n.workerExtraCostButton,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.control),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Primary CTA: "Hoàn tất công việc -> Chờ nghiệm thu"
            Builder(
              builder: (context) {
                final state = context.watch<WorkerTaskCubit>().state;
                final isBusy = state is WorkerTaskBusyState;
                return AppButton(
                  key: const Key('worker_complete_job_button'),
                  label: context.l10n.workerCompleteJobCta,
                  isLoading: isBusy,
                  onPressed: isBusy || state.data == null
                      ? null
                      : _showCompleteDialog,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
