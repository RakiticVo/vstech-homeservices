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
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/app_text_field.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/credential_rules.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/register_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/auth_role_badge.dart';

/// Screen 06 — Registration Screen.
/// Collects user details (Full name, Phone, Password) and creates the account through
/// [RegisterCubit] (`POST /auth/register`), then continues through the OTP step — simulated
/// (demo code 123456) until the backend ships an OTP API (docs/plans/API_INTEGRATION_PLAN.md §6).
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.initialRole = 'customer'});

  final String initialRole;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool _isWorker;
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = true;

  String? _fullNameError;
  String? _phoneError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _termsError;

  @override
  void initState() {
    super.initState();
    _isWorker = widget.initialRole == 'worker';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleRole() {
    setState(() {
      _isWorker = !_isWorker;
    });
  }

  void _onRegister() {
    final fullName = _fullNameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _fullNameError = fullName.isEmpty
          ? context.l10n.errorFieldRequired
          : (CredentialRules.isValidFullName(fullName) ? null : context.l10n.errorFullNameLength);
      _phoneError = phone.isEmpty
          ? context.l10n.errorFieldRequired
          : (CredentialRules.isValidVietnamesePhone(phone) ? null : context.l10n.errorInvalidPhone);
      _emailError = email.isEmpty
          ? context.l10n.errorFieldRequired
          : (CredentialRules.isValidEmail(email) ? null : context.l10n.errorInvalidEmail);
      _passwordError = password.isEmpty
          ? context.l10n.errorFieldRequired
          : password.length < 8
          ? context.l10n.errorPasswordTooShort
          : (CredentialRules.isStrongPassword(password) ? null : context.l10n.apiErrorWeakPassword);
      _confirmPasswordError = confirmPassword.isEmpty
          ? context.l10n.errorFieldRequired
          : (confirmPassword != password ? context.l10n.errorPasswordNotMatch : null);
      _termsError = !_agreedToTerms ? context.l10n.errorMustAgreeTerms : null;
    });

    if (_fullNameError != null ||
        _phoneError != null ||
        _emailError != null ||
        _passwordError != null ||
        _confirmPasswordError != null ||
        _termsError != null) {
      return;
    }

    FocusScope.of(context).unfocus();
    unawaited(
      context.read<RegisterCubit>().register(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
        role: _isWorker ? UserRole.worker : UserRole.customer,
      ),
    );
  }

  void _onStateChanged(BuildContext context, AuthFormState state) {
    switch (state) {
      case AuthFormSuccessState(:final role):
        unawaited(
          context.push(
            AppRoutes.verifyOtpLocation(phone: _phoneController.text.trim(), role: role.name, otpContext: 'register'),
          ),
        );
      case AuthFormFailureState(:final failure):
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(context.l10n.failureMessage(failure, context: FailureContext.auth))));
      case AuthFormInitialState() || AuthFormPrefilledState() || AuthFormSubmittingState():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, AuthFormState>(
      listener: _onStateChanged,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.login),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Center(
                child: AuthRoleBadge(isWorker: _isWorker, onSwitchRole: _toggleRole),
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

                // Title & Subtitle
                Text(
                  context.l10n.registerTitle,
                  style: AppTextStyles.headlineMd.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  context.l10n.registerSubtitle,
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Full Name field
                AppTextField(
                  label: context.l10n.registerFullNameLabel,
                  hintText: context.l10n.registerFullNameHint,
                  controller: _fullNameController,
                  errorText: _fullNameError,
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.person_outline, color: AppColors.textMuted, size: 20),
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: AppSpacing.md),

                // Phone number field
                AppTextField(
                  label: context.l10n.registerPhoneLabel,
                  hintText: context.l10n.registerPhoneHint,
                  controller: _phoneController,
                  errorText: _phoneError,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.textMuted, size: 20),
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: AppSpacing.md),

                // Email field (required by POST /auth/register)
                AppTextField(
                  key: const Key('register_email_field'),
                  label: context.l10n.registerEmailLabel,
                  hintText: context.l10n.registerEmailHint,
                  controller: _emailController,
                  errorText: _emailError,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail_outline, color: AppColors.textMuted, size: 20),
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: AppSpacing.md),

                // Password field
                AppTextField(
                  label: context.l10n.registerPasswordLabel,
                  hintText: context.l10n.registerPasswordHint,
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  errorText: _passwordError,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted, size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: AppSpacing.md),

                // Confirm Password field
                AppTextField(
                  label: context.l10n.registerConfirmPasswordLabel,
                  hintText: context.l10n.registerConfirmPasswordHint,
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  errorText: _confirmPasswordError,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted, size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _onRegister(),
                ),

                const SizedBox(height: AppSpacing.md),

                // Terms & Conditions checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreedToTerms,
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        side: const BorderSide(color: AppColors.border),
                        onChanged: (val) {
                          setState(() {
                            _agreedToTerms = val ?? false;
                            if (_agreedToTerms) _termsError = null;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '${context.l10n.registerTermsAgreement} ',
                            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              context.l10n.registerTermsLink,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            ' ${context.l10n.registerAndText} ',
                            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              context.l10n.registerPrivacyLink,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_termsError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 28),
                    child: Text(_termsError!, style: AppTextStyles.caption.copyWith(color: AppColors.error)),
                  ),

                const SizedBox(height: AppSpacing.xl),

                // Primary CTA: Register
                AppButton.primary(
                  label: context.l10n.registerCta,
                  onPressed: _onRegister,
                  isLoading: context.select<RegisterCubit, bool>((cubit) => cubit.state is AuthFormSubmittingState),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Footer: Already have an account? Sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.registerAlreadyHaveAccount,
                      style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    GestureDetector(
                      onTap: () {
                        final roleStr = _isWorker ? 'worker' : 'customer';
                        unawaited(context.push('${AppRoutes.login}?role=$roleStr'));
                      },
                      child: Text(
                        context.l10n.registerLoginNow,
                        style: AppTextStyles.bodyMd.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
