import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Dispute Report Page (Concept 02 — Cell 79 `dispute`)
/// Allows customer to report an issue, attach photos, and trigger escrow funds freeze.
class DisputeReportPage extends StatefulWidget {
  const DisputeReportPage({
    super.key,
    this.orderCode = 'HS-2026-0012',
  });

  final String orderCode;

  @override
  State<DisputeReportPage> createState() => _DisputeReportPageState();
}

class _DisputeReportPageState extends State<DisputeReportPage> {
  int? _selectedTypeIndex;
  final TextEditingController _descController = TextEditingController();
  int _attachedPhotoCount = 2; // Default mock with 2 attached photos

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final issueTypes = [
      context.l10n.disputeTypeQuality,
      context.l10n.disputeTypeDamage,
      context.l10n.disputeTypeAttitude,
      context.l10n.disputeTypeOvercharge,
      context.l10n.disputeTypeOther,
    ];

    final isSubmitEnabled = _selectedTypeIndex != null;

    return Scaffold(
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
          context.l10n.disputeTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Reference Header
              Text(
                context.l10n.complaintDetailOrderCode(widget.orderCode),
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Issue Category Prompt
              Text(
                context.l10n.disputeTypePrompt,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Category Options
              ...List.generate(issueTypes.length, (index) {
                final isSelected = _selectedTypeIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTypeIndex = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondarySurface : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                            color: isSelected ? AppColors.primary : AppColors.textMuted,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              issueTypes[index],
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: AppSpacing.lg),

              // Detailed Description Input
              Text(
                context.l10n.disputeDescPrompt,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _descController,
                maxLines: 4,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: context.l10n.disputeDescHint,
                  hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.all(AppSpacing.md),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Photos Gallery
              Text(
                context.l10n.disputePhotosPrompt,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  ...List.generate(_attachedPhotoCount, (idx) {
                    return Container(
                      width: 72,
                      height: 72,
                      margin: const EdgeInsets.only(right: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.image_outlined, color: AppColors.textMuted, size: 28),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _attachedPhotoCount--;
                                });
                              },
                              child: const Icon(Icons.cancel_rounded, size: 18, color: AppColors.error),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  if (_attachedPhotoCount < 5)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _attachedPhotoCount++;
                        });
                      },
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.control),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_a_photo_outlined, size: 20, color: AppColors.primary),
                            const SizedBox(height: 2),
                            Text(
                              context.l10n.disputeAddPhoto,
                              style: AppTextStyles.labelSmall.copyWith(
                                fontSize: 10,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // Escrow Protection Notice Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 22),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        context.l10n.disputeEscrowNotice,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Submit Button (locked until issue type is chosen)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSubmitEnabled
                      ? () {
                          unawaited(context.push(AppRoutes.orderDisputed));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    disabledBackgroundColor: AppColors.border,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.disputeSubmitBtn,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isSubmitEnabled ? AppColors.onPrimary : AppColors.textMuted,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
