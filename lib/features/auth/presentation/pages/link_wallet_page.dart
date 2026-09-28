import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing linking a new digital wallet (Cell 110 `pmlink`).
class LinkWalletPage extends StatefulWidget {
  const LinkWalletPage({super.key});

  @override
  State<LinkWalletPage> createState() => _LinkWalletPageState();
}

class _LinkWalletPageState extends State<LinkWalletPage> {
  int _step = 0; // 0 = select, 1 = confirm on app, 2 = success
  String _selectedWallet = 'momo';

  final _walletOptions = const [
    _WalletOption(
      id: 'momo',
      name: 'Ví MoMo',
      brand: 'MOMO',
      color: Color(0xFFA50064),
    ),
    _WalletOption(
      id: 'shopeepay',
      name: 'Ví ShopeePay',
      brand: 'SHOPEEPAY',
      color: Color(0xFFEE4D2D),
    ),
    _WalletOption(
      id: 'viettelmoney',
      name: 'Viettel Money',
      brand: 'VTMONEY',
      color: Color(0xFFEE0033),
    ),
  ];

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
              context.go(AppRoutes.paymentMethods);
            }
          },
        ),
        title: Text(
          l10n.linkWalletTitle,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: _buildCurrentStep(context),
              ),
            ),

            // Bottom CTA
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
                  key: const Key('link_wallet_action_button'),
                  onPressed: _handleStepAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  child: Text(
                    _step == 0
                        ? l10n.linkWalletContinueCta
                        : _step == 1
                            ? l10n.linkWalletIHaveConfirmedCta
                            : l10n.linkWalletBackToPmsCta,
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

  void _handleStepAction() {
    if (_step == 0) {
      setState(() => _step = 1);
    } else if (_step == 1) {
      setState(() => _step = 2);
    } else {
      context.pop();
    }
  }

  Widget _buildCurrentStep(BuildContext context) {
    final l10n = context.l10n;

    if (_step == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.linkWalletSelectPrompt,
            style: AppTextStyles.titleLg.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ..._walletOptions.map(_buildWalletSelectRow),
        ],
      );
    }

    if (_step == 1) {
      final selectedOpt =
          _walletOptions.firstWhere((w) => w.id == _selectedWallet);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 92,
              height: 62,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                selectedOpt.brand,
                style: AppTextStyles.titleLg.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: selectedOpt.color,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.linkWalletStepConfirmTitle,
              style: AppTextStyles.headlineMd.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                l10n.linkWalletStepConfirmDesc,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Step 2: Success
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(
              color: AppColors.secondarySurface,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.linkWalletStepSuccessTitle,
            style: AppTextStyles.headlineMd.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.linkWalletStepSuccessDesc,
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletSelectRow(_WalletOption opt) {
    final isSelected = _selectedWallet == opt.id;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secondarySurface : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: InkWell(
        key: Key('select_wallet_${opt.id}'),
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: () => setState(() => _selectedWallet = opt.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md - 2,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.border),
                ),
                alignment: Alignment.center,
                child: Text(
                  opt.brand,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color: opt.color,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  opt.name,
                  style: AppTextStyles.bodyMd.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: isSelected
                    ? Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletOption {
  const _WalletOption({
    required this.id,
    required this.name,
    required this.brand,
    required this.color,
  });

  final String id;
  final String name;
  final String brand;
  final Color color;
}
