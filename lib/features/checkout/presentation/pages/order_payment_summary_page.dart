import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Order Payment Summary Screen (`paysum` — Concept 02: Cell 52).
/// Itemized financial invoice with payment method selection and Amber commitment CTA.
class OrderPaymentSummaryPage extends StatefulWidget {
  const OrderPaymentSummaryPage({
    super.key,
    this.labourFee = 350000,
    this.addonsFee = 30000,
    this.premisesFee = 20000,
    this.extraMaterialFee = 0,
    this.orderCode = 'HS-2026-0012',
  });

  final int labourFee;
  final int addonsFee;
  final int premisesFee;
  final int extraMaterialFee;
  final String orderCode;

  @override
  State<OrderPaymentSummaryPage> createState() => _OrderPaymentSummaryPageState();
}

class _OrderPaymentSummaryPageState extends State<OrderPaymentSummaryPage> {
  late int _extraFee;
  String _selectedPaymentMethod = 'vietqr'; // 'vietqr', 'vnpay', 'cash'

  @override
  void initState() {
    super.initState();
    _extraFee = widget.extraMaterialFee;
  }

  int get _totalAmount =>
      widget.labourFee + widget.addonsFee + widget.premisesFee + _extraFee;

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
          context.l10n.paymentSummaryTitle,
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
          // Order Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.control),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    context.l10n.trackingOrderCode(widget.orderCode),
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    context.l10n.inspectSatisfiedCta,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Itemized Invoice Card
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
                Text(
                  context.l10n.bookingOrderSummary,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.md),
                _buildPriceRow(context.l10n.bookingBaseLabourFee, widget.labourFee),
                const SizedBox(height: AppSpacing.sm),
                _buildPriceRow(context.l10n.bookingAddonsFee, widget.addonsFee),
                const SizedBox(height: AppSpacing.sm),
                _buildPriceRow(context.l10n.bookingPremisesFee, widget.premisesFee),
                if (_extraFee > 0) ...[
                  const SizedBox(height: AppSpacing.sm),
                  _buildPriceRow(context.l10n.paymentExtraCost, _extraFee, isHighlight: true),
                ],
                const SizedBox(height: AppSpacing.md),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.paymentTotalToPay,
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      _formatPrice(_totalAmount),
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Payment Methods Selection
          Text(
            context.l10n.bookingPaymentMethod,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          _buildPaymentOptionTile(
            id: 'vietqr',
            title: context.l10n.bookingPaymentVietQR,
            subtitle: context.l10n.bookingPaymentVietQRDesc,
            icon: Icons.qr_code_2_rounded,
          ),
          const SizedBox(height: AppSpacing.sm),

          _buildPaymentOptionTile(
            id: 'vnpay',
            title: context.l10n.bookingPaymentVnPay,
            subtitle: context.l10n.bookingPaymentVnPayDesc,
            icon: Icons.credit_card_rounded,
          ),
          const SizedBox(height: AppSpacing.sm),

          _buildPaymentOptionTile(
            id: 'cash',
            title: context.l10n.bookingPaymentCash,
            subtitle: context.l10n.bookingPaymentCashDesc,
            icon: Icons.payments_outlined,
          ),

          const SizedBox(height: AppSpacing.xl),

          // Amber Financial Commitment CTA Button
          AppButton(
            label: context.l10n.paymentPayNowCta(_formatPrice(_totalAmount)),
            backgroundColor: AppColors.warning,
            textColor: AppColors.textPrimary,
            onPressed: () {
              if (_selectedPaymentMethod == 'vietqr') {
                unawaited(
                  context.push(
                    '${AppRoutes.paymentGateway}?amount=$_totalAmount&code=${widget.orderCode}',
                  ),
                );
              } else {
                unawaited(
                  context.push(
                    '${AppRoutes.paymentSuccess}?amount=$_totalAmount&code=${widget.orderCode}',
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, int amount, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isHighlight ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isHighlight ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        Text(
          _formatPrice(amount),
          style: AppTextStyles.bodyMedium.copyWith(
            color: isHighlight ? AppColors.primary : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOptionTile({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _selectedPaymentMethod == id;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = id;
        });
      },
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.control),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: isSelected ? 6 : 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
