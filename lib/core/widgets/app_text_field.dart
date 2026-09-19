import 'package:flutter/material.dart';

import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// Shared text input. Feature pages must use this instead of a raw [TextField]/[TextFormField],
/// per CLAUDE.md UI Component Rules — styling comes entirely from `InputDecorationTheme`.
class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    super.key,
    this.controller,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.enabled = true,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      enabled: enabled,
      style: AppTextStyles.bodyLg,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }
}
