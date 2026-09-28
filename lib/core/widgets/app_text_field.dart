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
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: enabled,
      maxLines: obscureText ? 1 : maxLines,
      style: AppTextStyles.bodyLg,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
