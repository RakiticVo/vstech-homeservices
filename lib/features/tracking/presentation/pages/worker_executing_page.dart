import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/service_checklist_widget.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/working_timer_widget.dart';

/// Worker Service Execution Screen (`wwork` — Concept 02: Cell 48).
/// Real-time working timer, interactive 5-step checklist, extra-cost proposal, and job completion.
class WorkerExecutingPage extends StatefulWidget {
  const WorkerExecutingPage({super.key});

  @override
  State<WorkerExecutingPage> createState() => _WorkerExecutingPageState();
}

class _WorkerExecutingPageState extends State<WorkerExecutingPage> {
  final Set<int> _completedSteps = {0, 1};
  int _currentStep = 2;

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
    final nameController = TextEditingController(text: 'Thay ron vòi sen');
    final priceController = TextEditingController(text: '45.000');

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
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: context.l10n.workerItemName,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
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
              'Huỷ',
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.workerProposalSent)),
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
            icon: const Icon(Icons.build_circle_outlined, size: 20, color: AppColors.primary),
            label: Text(
              context.l10n.workerExtraCostButton,
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
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
          AppButton(
            label: context.l10n.workerCompleteJobCta,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.workerCompleteJobCta)),
              );
            },
          ),
        ],
      ),
    );
  }
}
