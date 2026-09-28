import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/otp_pin_input_widget.dart';

/// Screen 07 — Shared OTP Verification Screen.
/// Shared across Register, Login, Forgot Password, and Worker KYC.
/// Includes 60s countdown resend timer and 1-tap "From SMS: 123456" quick fill banner.
class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    this.phone = '0901 234 567',
    this.role = 'customer',
    this.otpContext = 'register',
  });

  final String phone;
  final String role;
  final String otpContext;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final GlobalKey<OtpPinInputWidgetState> _pinInputKey = GlobalKey<OtpPinInputWidgetState>();
  String _pin = '';
  bool _hasError = false;
  bool _isLoading = false;

  Timer? _countdownTimer;
  int _countdownSeconds = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownSeconds = 60;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownSeconds <= 1) {
        timer.cancel();
        setState(() => _countdownSeconds = 0);
      } else {
        setState(() => _countdownSeconds--);
      }
    });
  }

  void _onResendOtp() {
    if (_countdownSeconds > 0) return;
    setState(() {
      _hasError = false;
    });
    _pinInputKey.currentState?.clearPin();
    _startCountdown();
  }

  void _onQuickFillDemo() {
    // Fill "123456" demo code per DESIGN.md §6b
    _pinInputKey.currentState?.setPin('123456');
  }

  void _onVerify() {
    if (_pin.length != 6) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    // Simulate verification
    Timer(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      // Verify correctness (demo valid code is 123456)
      if (_pin == '123456') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.otpVerifySuccess),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 2),
          ),
        );

        // Routing based on context
        if (widget.otpContext == 'forgot') {
          unawaited(context.push('${AppRoutes.login}?role=${widget.role}'));
        } else if (widget.role == 'customer') {
          unawaited(context.push(AppRoutes.customerHome));
        } else if (widget.otpContext == 'register') {
          unawaited(context.push(AppRoutes.workerKyc));
        } else {
          unawaited(context.push(AppRoutes.workerDashboard));
        }
      } else {
        setState(() => _hasError = true);
      }
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
                context.l10n.otpTitle,
                style: AppTextStyles.headlineMd.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                  children: [
                    TextSpan(text: '${context.l10n.otpSubtitle} '),
                    TextSpan(
                      text: widget.phone,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // 6-digit OTP Pin input
              OtpPinInputWidget(
                key: _pinInputKey,
                hasError: _hasError,
                onChanged: (pin) {
                  setState(() {
                    _pin = pin;
                    if (_hasError) _hasError = false;
                  });
                },
                onCompleted: (pin) {
                  _pin = pin;
                  _onVerify();
                },
              ),

              // Error notice if code is invalid
              if (_hasError)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, size: 16, color: AppColors.error),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          context.l10n.otpInvalidCode,
                          style: AppTextStyles.caption.copyWith(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: AppSpacing.lg),

              // Demo Quick-Fill Banner ("Từ Tin nhắn: 123456")
              Center(
                child: InkWell(
                  onTap: _onQuickFillDemo,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.secondarySurface,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.sms_outlined,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          context.l10n.otpQuickFillLabel,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Primary CTA: Verify
              AppButton.primary(
                label: context.l10n.otpCta,
                onPressed: _pin.length == 6 ? _onVerify : null,
                isLoading: _isLoading,
              ),

              const SizedBox(height: AppSpacing.xl),

              // Resend countdown timer or action
              Center(
                child: _countdownSeconds > 0
                    ? Text(
                        context.l10n.otpResendCountdown(_countdownSeconds),
                        style: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.textMuted,
                        ),
                      )
                    : TextButton(
                        onPressed: _onResendOtp,
                        child: Text(
                          context.l10n.otpResendAction,
                          style: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
