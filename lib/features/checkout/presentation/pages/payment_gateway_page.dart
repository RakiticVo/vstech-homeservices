import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Instant VietQR Gateway Screen (`pay` — Concept 02: Cell 53).
/// Displays real-time banking QR code, bank transfer details, and confirmation trigger.
/// Cancelling the transaction or letting the QR expire leads to the failed state (Cell 45).
class PaymentGatewayPage extends StatefulWidget {
  const PaymentGatewayPage({
    super.key,
    this.amount = 400000,
    this.orderCode = 'HS-2026-0012',
    this.initialFailed = false,
  });

  final int amount;
  final String orderCode;

  /// Opens directly on the failed state (used for previews/deep links).
  final bool initialFailed;

  @override
  State<PaymentGatewayPage> createState() => _PaymentGatewayPageState();
}

class _PaymentGatewayPageState extends State<PaymentGatewayPage> {
  int _secondsLeft = 899; // 14:59
  Timer? _countdownTimer;
  late bool _isFailed;

  @override
  void initState() {
    super.initState();
    _isFailed = widget.initialFailed;
    if (!_isFailed) _startCountdown();
  }

  void _startCountdown() {
    _secondsLeft = 899;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsLeft > 1) {
        setState(() => _secondsLeft--);
      } else {
        timer.cancel();
        setState(() {
          _secondsLeft = 0;
          _isFailed = true;
        });
      }
    });
  }

  void _onCancelTransaction() {
    _countdownTimer?.cancel();
    setState(() => _isFailed = true);
  }

  void _onRetry() {
    setState(() => _isFailed = false);
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  String _formatPrice(int amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(amount)}đ';
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
          context.l10n.gatewayTitle,
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
      body: _isFailed ? _buildFailedBody(context) : ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Prompt & Expiration Banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius: BorderRadius.circular(AppRadius.control),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined, color: AppColors.primary, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    context.l10n.gatewayCountdown(
                      (_secondsLeft ~/ 60).toString().padLeft(2, '0'),
                      (_secondsLeft % 60).toString().padLeft(2, '0'),
                    ),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // VietQR Code Box
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'VietQR 24/7',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        'Napas247',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Simulated QR Box Frame
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.qr_code_rounded,
                          size: 140,
                          color: AppColors.textPrimary,
                        ),
                        Text(
                          widget.orderCode,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),
                Text(
                  _formatPrice(widget.amount),
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  context.l10n.gatewayScanQrPrompt,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Transfer Credentials Table
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCopyRow(
                  context.l10n.gatewayAccountOwner,
                  'CONG TY CONG NGHE VSTECH',
                  context,
                ),
                const Divider(height: 20, color: AppColors.border),
                _buildCopyRow(
                  context.l10n.gatewayBankName,
                  'MB Bank (Napas247)',
                  context,
                ),
                const Divider(height: 20, color: AppColors.border),
                _buildCopyRow(
                  context.l10n.kycAccountNumber,
                  '0987654321',
                  context,
                ),
                const Divider(height: 20, color: AppColors.border),
                _buildCopyRow(
                  context.l10n.gatewayTransferContent,
                  widget.orderCode.replaceAll('-', ''),
                  context,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Primary CTA: "Tôi đã chuyển khoản thành công"
          AppButton(
            label: context.l10n.gatewayConfirmTransferred,
            onPressed: () {
              unawaited(
                context.push(
                  '${AppRoutes.paymentSuccess}?amount=${widget.amount}&code=${widget.orderCode}',
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: TextButton(
              key: const Key('gateway_cancel_transaction'),
              onPressed: _onCancelTransaction,
              child: Text(
                context.l10n.gatewayCancelTransaction,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailedBody(BuildContext context) {
    final l10n = context.l10n;
    final reason =
        _secondsLeft == 0 ? l10n.gatewayFailExpired : l10n.gatewayFailCancelled;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.error),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 40,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.gatewayFailTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineMd.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '$reason ${l10n.gatewayNoCharge}',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppButton.primary(
              key: const Key('gateway_retry'),
              label: l10n.retry,
              icon: Icons.refresh_rounded,
              onPressed: _onRetry,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppSecondaryButton(
              key: const Key('gateway_change_method'),
              label: l10n.gatewayChangeMethod,
              isFullWidth: true,
              icon: Icons.swap_horiz_rounded,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCopyRow(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy_rounded, size: 18, color: AppColors.primary),
          onPressed: () {
            unawaited(Clipboard.setData(ClipboardData(text: value)));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.copiedToClipboard(value))),
            );
          },
        ),
      ],
    );
  }
}
