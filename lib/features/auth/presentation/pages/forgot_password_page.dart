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

/// Screen 08 — Forgot Password Screen.
/// Collects user's registered phone number to issue a recovery OTP.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
    this.phone = '',
    this.role = 'customer',
  });

  final String phone;
  final String role;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final TextEditingController _phoneController;
  String? _phoneError;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final phone = _phoneController.text.trim();
    setState(() {
      _phoneError = phone.isEmpty
          ? context.l10n.errorFieldRequired
          : (phone.length < 9 ? context.l10n.errorInvalidPhone : null);
    });

    if (_phoneError != null) return;

    setState(() => _isLoading = true);

    Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      unawaited(
        context.push(
          '${AppRoutes.verifyOtp}?phone=${Uri.encodeComponent(phone)}&role=${widget.role}&context=forgot',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),

              // Title & Subtitle
              Text(
                context.l10n.forgotPasswordTitle,
                style: AppTextStyles.headlineMd.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.l10n.forgotPasswordSubtitle,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Phone number field
              AppTextField(
                label: context.l10n.forgotPasswordPhoneLabel,
                hintText: context.l10n.forgotPasswordPhoneHint,
                controller: _phoneController,
                errorText: _phoneError,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: AppColors.textMuted,
                  size: 20,
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _onSubmit(),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Primary CTA: Send Verification Code
              AppButton.primary(
                label: context.l10n.forgotPasswordCta,
                onPressed: _onSubmit,
                isLoading: _isLoading,
              ),

              const SizedBox(height: AppSpacing.xl),

              // Footer: Back to login
              Center(
                child: TextButton(
                  onPressed: () => context.pop(),
                  child: Text(
                    context.l10n.forgotPasswordBackToLogin,
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
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
