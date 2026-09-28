import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen displaying the customer's linked payment methods (Cell 109 `pms`).
class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final List<_WalletItem> _wallets = [
    _WalletItem(
      id: 'vnpay',
      brand: 'VNPAY',
      name: 'Ví điện tử VNPay',
      maskedPhone: '0901 ••• 567',
      isDefault: true,
      brandColor: const Color(0xFF005BAA),
    ),
    _WalletItem(
      id: 'zalopay',
      brand: 'ZALOPAY',
      name: 'Ví điện tử ZaloPay',
      maskedPhone: '0901 ••• 567',
      isDefault: false,
      brandColor: const Color(0xFF0068FF),
    ),
  ];

  void _setDefault(String id) {
    setState(() {
      for (final w in _wallets) {
        w.isDefault = w.id == id;
      }
    });
  }

  void _unlinkWallet(String id) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogCtx) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          title: Text(
            context.l10n.pmsUnlink,
            style: AppTextStyles.titleLg.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          content: Text(
            context.l10n.pmsUnlinkConfirm,
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: Text(
                'Huỷ',
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              key: const Key('confirm_unlink_button'),
              onPressed: () {
                Navigator.of(dialogCtx).pop();
                setState(() {
                  _wallets.removeWhere((w) => w.id == id);
                });
              },
              child: Text(
                context.l10n.pmsUnlink,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
              context.go(AppRoutes.customerProfile);
            }
          },
        ),
        title: Text(
          l10n.pmsTitle,
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
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                children: [
                  ..._wallets.map((w) => _buildWalletCard(context, w)),

                  const SizedBox(height: AppSpacing.md),

                  // PCI-DSS security note
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.shield_outlined,
                          color: AppColors.primary,
                          size: 22,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            l10n.pmsSecurityNote,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Link new wallet CTA
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  key: const Key('link_new_wallet_button'),
                  onPressed: () => context.push(AppRoutes.linkWallet),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  child: Text(
                    l10n.pmsLinkWalletCta,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
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

  Widget _buildWalletCard(BuildContext context, _WalletItem wallet) {
    final l10n = context.l10n;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.border),
                ),
                alignment: Alignment.center,
                child: Text(
                  wallet.brand,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color: wallet.brandColor,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            wallet.name,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.titleLg.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (wallet.isDefault) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondarySurface,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.chip),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              l10n.addressesDefaultBadge,
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      wallet.maskedPhone,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.sm),

          // Actions
          Row(
            children: [
              if (wallet.isDefault)
                Expanded(
                  child: Text(
                    l10n.pmsDefaultLabel,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              else ...[
                Flexible(
                  child: InkWell(
                    key: Key('set_default_wallet_${wallet.id}'),
                    onTap: () => _setDefault(wallet.id),
                    child: Text(
                      l10n.pmsSetDefault,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                InkWell(
                  key: Key('unlink_wallet_${wallet.id}'),
                  onTap: () => _unlinkWallet(wallet.id),
                  child: Text(
                    l10n.pmsUnlink,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _WalletItem {
  _WalletItem({
    required this.id,
    required this.brand,
    required this.name,
    required this.maskedPhone,
    required this.isDefault,
    required this.brandColor,
  });

  final String id;
  final String brand;
  final String name;
  final String maskedPhone;
  bool isDefault;
  final Color brandColor;
}
