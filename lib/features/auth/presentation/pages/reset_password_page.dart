import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/app_text_field.dart';

/// New Password Screen (`newpass` — Concept 02: Cell 28).
/// Reached after the forgot-password OTP; the CTA stays locked until every rule passes.
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    this.role = 'customer',
  });

  final String role;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _newPassController.addListener(_onChanged);
    _confirmPassController.addListener(_onChanged);
  }

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _onChanged() => setState(() {});

  bool get _hasMinLength => _newPassController.text.length >= 8;

  bool get _hasLettersAndDigits =>
      RegExp('[A-Za-z]').hasMatch(_newPassController.text) &&
      RegExp(r'\d').hasMatch(_newPassController.text);

  bool get _isConfirmMismatch =>
      _confirmPassController.text.isNotEmpty &&
      _confirmPassController.text != _newPassController.text;

  bool get _canSubmit =>
      _hasMinLength &&
      _hasLettersAndDigits &&
      _confirmPassController.text == _newPassController.text;

  void _onSubmit() {
    setState(() => _isLoading = true);
    Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      context.go('${AppRoutes.resetPasswordSuccess}?role=${widget.role}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.resetPasswordTitle,
                      style: AppTextStyles.headlineMd.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.resetPasswordSubtitle,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppTextField(
                      key: const Key('reset_password_new'),
                      label: l10n.resetPasswordNewLabel,
                      controller: _newPassController,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      key: const Key('reset_password_confirm'),
                      label: l10n.resetPasswordConfirmLabel,
                      controller: _confirmPassController,
                      obscureText: true,
                      errorText:
                          _isConfirmMismatch ? l10n.resetPasswordMismatch : null,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _RuleRow(
                      label: l10n.resetPasswordRuleLength,
                      isMet: _hasMinLength,
                    ),
                    _RuleRow(
                      label: l10n.resetPasswordRuleMix,
                      isMet: _hasLettersAndDigits,
                    ),
                    // Checked server-side against the old hash; shown as guidance only.
                    _RuleRow(
                      label: l10n.resetPasswordRuleDifferent,
                      isMet: _newPassController.text.isNotEmpty,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: AppButton.primary(
                key: const Key('reset_password_submit'),
                label: l10n.resetPasswordCta,
                isLoading: _isLoading,
                onPressed: _canSubmit ? _onSubmit : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.label, required this.isMet});

  final String label;
  final bool isMet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            size: 20,
            color: isMet ? AppColors.success : AppColors.textMuted,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMd.copyWith(
                color: isMet ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
