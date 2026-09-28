import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_step_indicator.dart';

/// Step 3 of Customer Booking: Review itemized bill, apply voucher, choose payment method, and confirm order.
class BookingStep3ConfirmPage extends StatefulWidget {
  const BookingStep3ConfirmPage({
    this.basePrice = 350000,
    this.addonsPrice = 30000,
    this.premisesPrice = 20000,
    this.premisesId = 'elevator',
    this.date = 'today',
    this.slot = '14:00 - 16:00',
    super.key,
  });

  final int basePrice;
  final int addonsPrice;
  final int premisesPrice;
  final String premisesId;
  final String date;
  final String slot;

  @override
  State<BookingStep3ConfirmPage> createState() => _BookingStep3ConfirmPageState();
}

class _BookingStep3ConfirmPageState extends State<BookingStep3ConfirmPage> {
  final TextEditingController _voucherController = TextEditingController(text: 'NHAMOICHI15');
  bool _isVoucherApplied = true;
  int _voucherDiscount = 50000;
  String _selectedPaymentMethod = 'vietqr'; // 'vietqr', 'vnpay', 'cash'

  int get _subtotal => widget.basePrice + widget.addonsPrice + widget.premisesPrice;
  int get _finalTotal => (_subtotal - (_isVoucherApplied ? _voucherDiscount : 0)).clamp(0, 999999999);

  String _formatPrice(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    var count = 0;
    for (var i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }
    return '${buffer.toString().split('').reversed.join()}đ';
  }

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  void _applyVoucher() {
    final code = _voucherController.text.trim().toUpperCase();
    if (code.isNotEmpty) {
      setState(() {
        _isVoucherApplied = true;
        _voucherDiscount = 50000;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.bookingVoucherApplied),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _removeVoucher() {
    setState(() {
      _isVoucherApplied = false;
      _voucherDiscount = 0;
      _voucherController.clear();
    });
  }

  void _onConfirmBooking() {
    unawaited(context.push(AppRoutes.bookingMatching));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BookingStepIndicator(
        currentStep: 3,
        stepTitle: context.l10n.bookingStep3Title,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  // Schedule & Address recap chip
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                '${widget.date == 'today' ? context.l10n.bookingScheduleToday : context.l10n.bookingScheduleTomorrow} • ${widget.slot}',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                'Căn hộ B12.04, Masteri Thảo Điền, TP. Thủ Đức',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Itemized Cost Breakdown
                  Text(
                    context.l10n.bookingOrderSummary,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        _PriceRow(
                          label: context.l10n.bookingBaseLabourFee,
                          value: _formatPrice(widget.basePrice),
                        ),
                        if (widget.addonsPrice > 0) ...[
                          const SizedBox(height: AppSpacing.sm),
                          _PriceRow(
                            label: context.l10n.bookingAddonsFee,
                            value: '+${_formatPrice(widget.addonsPrice)}',
                          ),
                        ],
                        const SizedBox(height: AppSpacing.sm),
                        _PriceRow(
                          label: context.l10n.bookingPremisesFee,
                          value: widget.premisesPrice > 0
                              ? '+${_formatPrice(widget.premisesPrice)}'
                              : '+0đ',
                        ),
                        if (_isVoucherApplied) ...[
                          const SizedBox(height: AppSpacing.sm),
                          _PriceRow(
                            label: context.l10n.bookingDiscountFee,
                            value: '-${_formatPrice(_voucherDiscount)}',
                            valueColor: AppColors.success,
                          ),
                        ],
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                          child: Divider(color: AppColors.border, height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                context.l10n.bookingTotalEstimated,
                                style: AppTextStyles.bodyLarge.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Text(
                              _formatPrice(_finalTotal),
                              style: AppTextStyles.headlineSmall.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Voucher promo code input
                  Text(
                    context.l10n.bookingVoucherLabel,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(AppRadius.control),
                            border: Border.all(
                              color: _isVoucherApplied ? AppColors.success : AppColors.border,
                            ),
                          ),
                          child: TextField(
                            controller: _voucherController,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              hintText: context.l10n.bookingVoucherHint,
                              hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.confirmation_number_outlined,
                                size: 20,
                                color: _isVoucherApplied ? AppColors.success : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      if (_isVoucherApplied)
                        OutlinedButton(
                          onPressed: _removeVoucher,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.control),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: const Icon(Icons.close, size: 18),
                        )
                      else
                        ElevatedButton(
                          onPressed: _applyVoucher,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.control),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text(
                            context.l10n.bookingVoucherApply,
                            style: AppTextStyles.buttonText.copyWith(
                              color: AppColors.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Payment Method Selector
                  Text(
                    context.l10n.bookingPaymentMethod,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _PaymentMethodTile(
                    id: 'vietqr',
                    icon: Icons.qr_code_2_rounded,
                    title: context.l10n.bookingPaymentVietQR,
                    desc: context.l10n.bookingPaymentVietQRDesc,
                    isSelected: _selectedPaymentMethod == 'vietqr',
                    onTap: () => setState(() => _selectedPaymentMethod = 'vietqr'),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _PaymentMethodTile(
                    id: 'vnpay',
                    icon: Icons.credit_card_rounded,
                    title: context.l10n.bookingPaymentVnPay,
                    desc: context.l10n.bookingPaymentVnPayDesc,
                    isSelected: _selectedPaymentMethod == 'vnpay',
                    onTap: () => setState(() => _selectedPaymentMethod = 'vnpay'),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _PaymentMethodTile(
                    id: 'cash',
                    icon: Icons.payments_outlined,
                    title: context.l10n.bookingPaymentCash,
                    desc: context.l10n.bookingPaymentCashDesc,
                    isSelected: _selectedPaymentMethod == 'cash',
                    onTap: () => setState(() => _selectedPaymentMethod = 'cash'),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Eco-Clean Guarantee Notices
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.secondarySurface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.verified_outlined,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                context.l10n.bookingWarranty30DaysBadge,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          context.l10n.bookingPayAfterInspectNotice,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Pinned Bottom Amber CTA per Concept 02
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onConfirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warning,
                    foregroundColor: AppColors.surface,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    context.l10n.bookingConfirmCta(_formatPrice(_finalTotal)),
                    style: AppTextStyles.buttonText.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  const _PaymentMethodTile({
    required this.id,
    required this.icon,
    required this.title,
    required this.desc,
    required this.isSelected,
    required this.onTap,
  });

  final String id;
  final IconData icon;
  final String title;
  final String desc;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
        padding: const EdgeInsets.all(AppSpacing.md),
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
              icon,
              size: 24,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    desc,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
