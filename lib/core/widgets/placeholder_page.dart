import 'package:flutter/material.dart';

import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// Temporary landing screen shown until the `auth` feature is scaffolded. Remove once
/// `AppRoutes.login` (or an authenticated home route) is wired as the real initial route.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(label, style: AppTextStyles.headlineMd, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
