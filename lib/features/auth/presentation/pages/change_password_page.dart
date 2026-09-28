import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing customer password change (Cell 114 `chpass`).
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _curPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _isObscureCur = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;
  bool _isSuccess = false;

  @override
  void dispose() {
    _curPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    setState(() => _isSuccess = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.changePasswordSuccess)),
    );
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
              context.go(AppRoutes.customerSettings);
            }
          },
        ),
        title: Text(
          l10n.changePasswordTitle,
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_isSuccess) ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.secondarySurface,
                          borderRadius: BorderRadius.circular(AppRadius.control),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.changePasswordSuccess,
                                style: AppTextStyles.bodyMd.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    _buildPasswordField(
                      keyName: 'current',
                      label: l10n.changePasswordCurrent,
                      controller: _curPassController,
                      isObscure: _isObscureCur,
                      onToggleObscure: () =>
                          setState(() => _isObscureCur = !_isObscureCur),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    _buildPasswordField(
                      keyName: 'new',
                      label: l10n.changePasswordNew,
                      controller: _newPassController,
                      isObscure: _isObscureNew,
                      onToggleObscure: () =>
                          setState(() => _isObscureNew = !_isObscureNew),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    _buildPasswordField(
                      keyName: 'confirm',
                      label: l10n.changePasswordConfirm,
                      controller: _confirmPassController,
                      isObscure: _isObscureConfirm,
                      onToggleObscure: () => setState(
                          () => _isObscureConfirm = !_isObscureConfirm),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      l10n.changePasswordRule,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textMuted,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Submit CTA
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
                  key: const Key('submit_change_password_button'),
                  onPressed: _handleChangePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  child: Text(
                    l10n.changePasswordCta,
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

  Widget _buildPasswordField({
    required String keyName,
    required String label,
    required TextEditingController controller,
    required bool isObscure,
    required VoidCallback onToggleObscure,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.center,
          child: TextField(
            key: Key('password_input_$keyName'),
            controller: controller,
            obscureText: isObscure,
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textMuted,
                  size: 20,
                ),
                onPressed: onToggleObscure,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
