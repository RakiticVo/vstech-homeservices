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
import 'package:vstech_home_services/features/auth/presentation/widgets/auth_role_badge.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/social_auth_button.dart';

/// Screen 05 — Role-Aware Login Screen.
/// Supports both Customer (Phone/Email + Social) and Worker (Phone only).
class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.initialRole = 'customer',
  });

  final String initialRole;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _isWorker;
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _identifierError;
  String? _passwordError;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isWorker = widget.initialRole == 'worker';
    // Pre-fill demo identifier per DESIGN.md §6b
    _identifierController.text = _isWorker ? '0912 345 678' : '0901 234 567';
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleRole() {
    setState(() {
      _isWorker = !_isWorker;
      _identifierController.text = _isWorker ? '0912 345 678' : '0901 234 567';
      _identifierError = null;
      _passwordError = null;
    });
  }

  void _onLogin() {
    final identifier = _identifierController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _identifierError = identifier.isEmpty ? context.l10n.errorFieldRequired : null;
      _passwordError = password.isEmpty ? context.l10n.errorFieldRequired : null;
    });

    if (_identifierError != null || _passwordError != null) return;

    setState(() => _isLoading = true);

    // Simulate login completion and navigate to OTP or Home
    Timer(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      final roleStr = _isWorker ? 'worker' : 'customer';
      unawaited(
        context.push(
          '${AppRoutes.verifyOtp}?phone=${Uri.encodeComponent(identifier)}&role=$roleStr&context=login',
        ),
      );
    });
  }

  void _onForgotPassword() {
    final roleStr = _isWorker ? 'worker' : 'customer';
    final phone = _identifierController.text.trim();
    unawaited(
      context.push(
        '${AppRoutes.forgotPassword}?role=$roleStr&phone=${Uri.encodeComponent(phone)}',
      ),
    );
  }

  void _onNavigateToRegister() {
    final roleStr = _isWorker ? 'worker' : 'customer';
    unawaited(context.push('${AppRoutes.register}?role=$roleStr'));
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
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.roleGateway),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Center(
              child: AuthRoleBadge(
                isWorker: _isWorker,
                onSwitchRole: _toggleRole,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),

              // Title & Welcome
              Text(
                context.l10n.loginTitle,
                style: AppTextStyles.headlineMd.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.l10n.loginWelcome,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Identifier input field (Phone or Email for customer, Phone for worker)
              AppTextField(
                label: _isWorker
                    ? context.l10n.loginPhoneWorkerLabel
                    : context.l10n.loginPhoneOrEmailLabel,
                hintText: _isWorker
                    ? context.l10n.loginPhoneWorkerHint
                    : context.l10n.loginPhoneOrEmailHint,
                controller: _identifierController,
                errorText: _identifierError,
                keyboardType: _isWorker ? TextInputType.phone : TextInputType.emailAddress,
                prefixIcon: Icon(
                  _isWorker ? Icons.phone_outlined : Icons.account_circle_outlined,
                  color: AppColors.textMuted,
                  size: 20,
                ),
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: AppSpacing.md),

              // Password input field with show/hide toggle
              AppTextField(
                label: context.l10n.loginPasswordLabel,
                hintText: context.l10n.loginPasswordHint,
                controller: _passwordController,
                obscureText: _obscurePassword,
                errorText: _passwordError,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _onLogin(),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.textMuted,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.xs),

              // Forgot password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _onForgotPassword,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    context.l10n.loginForgotPassword,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Primary CTA: Sign In
              AppButton.primary(
                label: context.l10n.loginCta,
                onPressed: _onLogin,
                isLoading: _isLoading,
              ),

              // Social Logins (Customer only per DESIGN.md §6b)
              if (!_isWorker) ...[
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.border)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                      child: Text(
                        context.l10n.loginOrSocialDivider,
                        style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.border)),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                SocialAuthButton(
                  provider: SocialProvider.google,
                  label: context.l10n.loginGoogle,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                SocialAuthButton(
                  provider: SocialProvider.apple,
                  label: context.l10n.loginApple,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                SocialAuthButton(
                  provider: SocialProvider.facebook,
                  label: context.l10n.loginFacebook,
                  onPressed: () {},
                ),
              ],

              const SizedBox(height: AppSpacing.xl),

              // Footer: No account? Sign up now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.loginNoAccount,
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  GestureDetector(
                    onTap: _onNavigateToRegister,
                    child: Text(
                      context.l10n.loginRegisterNow,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
