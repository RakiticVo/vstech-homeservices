import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing customer account deletion (Cell 115 `delacc`).
class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  int _selectedReason = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final reasons = [
      l10n.deleteAccountReason1,
      l10n.deleteAccountReason2,
      l10n.deleteAccountReason3,
      l10n.deleteAccountReason4,
    ];

    final deletedItems = [
      l10n.deleteAccountItem1,
      l10n.deleteAccountItem2,
      l10n.deleteAccountItem3,
      l10n.deleteAccountItem4,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.customerSettings);
            }
          },
        ),
        title: Text(
          l10n.deleteAccountTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Danger Warning Banner
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE8E4),
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: const Color(0xFFF87171)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                color: AppColors.error,
                                size: 22,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  l10n.deleteAccountWarningTitle,
                                  style: AppTextStyles.titleLg.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.deleteAccountWarningBody,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Deleted items list card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: deletedItems.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '− ',
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: AppTextStyles.bodyMd.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Reason section
                    Text(
                      l10n.deleteAccountReasonTitle,
                      style: AppTextStyles.titleLg.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    ...reasons.asMap().entries.map((entry) {
                      final index = entry.key;
                      final text = entry.value;
                      final isSelected = _selectedReason == index;

                      return Container(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.secondarySurface
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                        ),
                        child: InkWell(
                          key: Key('delete_reason_$index'),
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          onTap: () => setState(() => _selectedReason = index),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.md - 2,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textMuted,
                                  size: 20,
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Text(
                                    text,
                                    style: AppTextStyles.bodyMd.copyWith(
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      color: AppColors.textPrimary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      key: const Key('confirm_delete_account_button'),
                      onPressed: () => context.go(AppRoutes.login),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.error, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                      ),
                      child: Text(
                        l10n.deleteAccountConfirmCta,
                        style: AppTextStyles.bodyMd.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.error,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    key: const Key('keep_account_button'),
                    onPressed: () => context.pop(),
                    child: Text(
                      l10n.deleteAccountKeepCta,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
