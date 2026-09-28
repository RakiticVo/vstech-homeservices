import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Customer Notification Settings Screen (Concept 02: Cell 65).
/// Fine-grained preferences for Push, SMS, Zalo ZNS, and Promotional alerts.
class CustomerNotificationSettingsPage extends StatefulWidget {
  const CustomerNotificationSettingsPage({super.key});

  @override
  State<CustomerNotificationSettingsPage> createState() => _CustomerNotificationSettingsPageState();
}

class _CustomerNotificationSettingsPageState extends State<CustomerNotificationSettingsPage> {
  bool _pushEnabled = true;
  bool _smsEnabled = true;
  bool _zaloEnabled = false;
  bool _promoEnabled = true;

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
          context.l10n.notifSettingsTitle,
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
          // Channels Card
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
                _buildSwitchTile(
                  title: context.l10n.notifSettingsPush,
                  subtitle: context.l10n.notifSettingsPushDesc,
                  value: _pushEnabled,
                  onChanged: (val) => setState(() => _pushEnabled = val),
                ),
                const Divider(height: 24, color: AppColors.border),
                _buildSwitchTile(
                  title: context.l10n.notifSettingsSms,
                  subtitle: context.l10n.notifSettingsSmsDesc,
                  value: _smsEnabled,
                  onChanged: (val) => setState(() => _smsEnabled = val),
                ),
                const Divider(height: 24, color: AppColors.border),
                _buildSwitchTile(
                  title: context.l10n.notifSettingsZalo,
                  subtitle: context.l10n.notifSettingsZaloDesc,
                  value: _zaloEnabled,
                  onChanged: (val) => setState(() => _zaloEnabled = val),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Promotional Card
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
                _buildSwitchTile(
                  title: context.l10n.notifSettingsPromo,
                  subtitle: context.l10n.notifSettingsPromoDesc,
                  value: _promoEnabled,
                  onChanged: (val) => setState(() => _promoEnabled = val),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Save Changes CTA
          AppButton(
            label: context.l10n.notifSettingsSave,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.notifSettingsSaved)),
              );
              Navigator.of(context).maybePop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: AppColors.primary,
        ),
      ],
    );
  }
}
