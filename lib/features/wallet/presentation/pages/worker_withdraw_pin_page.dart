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
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdraw_cubit.dart';

/// Worker withdrawal 6-digit PIN screen (Cell 121 `wwdpin`).
///
/// The PIN check is **simulated** — the API has no wallet PIN yet — so any 6 digits confirm; the
/// withdrawal itself is then sent with `POST /wallets/withdrawals` by [WithdrawCubit].
class WorkerWithdrawPinPage extends StatefulWidget {
  const WorkerWithdrawPinPage({super.key});

  @override
  State<WorkerWithdrawPinPage> createState() => _WorkerWithdrawPinPageState();
}

class _WorkerWithdrawPinPageState extends State<WorkerWithdrawPinPage> {
  String _pin = '';

  void _onKeyPress(String digit) {
    if (context.read<WithdrawCubit>().state is WithdrawSubmittingState) return;
    if (_pin.length < 6) {
      setState(() {
        _pin += digit;
      });

      if (_pin.length == 6) unawaited(context.read<WithdrawCubit>().submit());
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _onStateChanged(BuildContext context, WithdrawState state) {
    switch (state) {
      case WithdrawSubmittedState(:final withdrawal):
        context.go(AppRoutes.workerWithdrawStatusLocation(withdrawal.id));
      case WithdrawSubmitErrorState(:final failure):
        setState(() => _pin = '');
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(context.l10n.failureMessage(failure, context: FailureContext.wallet))));
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<WithdrawCubit>().state;
    final amount = MoneyFormatter.format(state.draft?.amount ?? 0);

    return BlocListener<WithdrawCubit, WithdrawState>(
      listener: _onStateChanged,
      child: Scaffold(
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
                context.go(AppRoutes.workerWithdraw);
              }
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),
              // Header icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.secondarySurface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.lock_outline, color: AppColors.primary, size: 28),
              ),
              const SizedBox(height: AppSpacing.md),

              // Title & amount
              Text(
                l10n.wwdpinTitle,
                style: AppTextStyles.headlineMd.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Text(
                  l10n.wwdpinSubtitle(amount),
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // 6 PIN dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  final isFilled = index < _pin.length;
                  return Container(
                    key: Key('pin_dot_$index'),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: isFilled ? AppColors.primary : AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: isFilled ? AppColors.primary : AppColors.border, width: 2),
                    ),
                  );
                }),
              ),
              const Spacer(),

              // Custom Number Keypad
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
                child: Column(
                  children: [
                    _buildKeypadRow(['1', '2', '3']),
                    const SizedBox(height: AppSpacing.md),
                    _buildKeypadRow(['4', '5', '6']),
                    const SizedBox(height: AppSpacing.md),
                    _buildKeypadRow(['7', '8', '9']),
                    const SizedBox(height: AppSpacing.md),
                    _buildKeypadBottomRow(),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((digit) {
        return _buildKeypadButton(
          key: Key('pin_key_$digit'),
          child: Text(
            digit,
            style: AppTextStyles.headlineMd.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontSize: 24,
            ),
          ),
          onTap: () => _onKeyPress(digit),
        );
      }).toList(),
    );
  }

  Widget _buildKeypadBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Empty space
        const SizedBox(width: 72, height: 60),
        _buildKeypadButton(
          key: const Key('pin_key_0'),
          child: Text(
            '0',
            style: AppTextStyles.headlineMd.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontSize: 24,
            ),
          ),
          onTap: () => _onKeyPress('0'),
        ),
        _buildKeypadButton(
          key: const Key('pin_key_backspace'),
          child: const Icon(Icons.backspace_outlined, color: AppColors.textPrimary, size: 22),
          onTap: _onBackspace,
        ),
      ],
    );
  }

  Widget _buildKeypadButton({required Key key, required Widget child, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: key,
        borderRadius: BorderRadius.circular(AppRadius.full),
        onTap: onTap,
        child: Container(
          width: 72,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(color: AppColors.border),
          ),
          child: child,
        ),
      ),
    );
  }
}
