import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// 6-digit OTP Pin input widget with automatic sequential focus advance and backspace handling.
/// Styled according to Eco-Clean Sanctuary tokens.
class OtpPinInputWidget extends StatefulWidget {
  const OtpPinInputWidget({
    required this.onChanged,
    required this.onCompleted,
    super.key,
    this.hasError = false,
  });

  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;
  final bool hasError;

  @override
  State<OtpPinInputWidget> createState() => OtpPinInputWidgetState();
}

class OtpPinInputWidgetState extends State<OtpPinInputWidget> {
  static const int pinLength = 6;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(pinLength, (_) => TextEditingController());
    _focusNodes = List.generate(pinLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  /// Programmatically set the 6-digit pin (e.g. from SMS quick fill).
  void setPin(String pin) {
    if (pin.length != pinLength) return;
    for (var i = 0; i < pinLength; i++) {
      _controllers[i].text = pin[i];
    }
    _focusNodes.last.requestFocus();
    widget.onChanged(pin);
    widget.onCompleted(pin);
    setState(() {});
  }

  /// Clear all pin digits and reset focus to first digit.
  void clearPin() {
    for (final controller in _controllers) {
      controller.clear();
    }
    _focusNodes.first.requestFocus();
    widget.onChanged('');
    setState(() {});
  }

  String get currentPin => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.length > 1) {
      // If user pasted or typed multiple digits
      final digits = value.replaceAll(RegExp(r'\D'), '');
      if (digits.length == pinLength) {
        setPin(digits);
        return;
      }
      _controllers[index].text = digits.isNotEmpty ? digits[0] : '';
    }

    final pin = currentPin;
    widget.onChanged(pin);

    if (value.isNotEmpty) {
      if (index < pinLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        if (pin.length == pinLength) {
          widget.onCompleted(pin);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(pinLength, (index) {
        final isFocused = _focusNodes[index].hasFocus;
        final hasValue = _controllers[index].text.isNotEmpty;

        Border border;
        Color backgroundColor;

        if (widget.hasError) {
          border = Border.all(color: AppColors.error, width: 1.5);
          backgroundColor = AppColors.surface;
        } else if (isFocused) {
          border = Border.all(color: AppColors.primary, width: 1.5);
          backgroundColor = AppColors.secondarySurface;
        } else if (hasValue) {
          border = Border.all(color: AppColors.primary.withValues(alpha: 0.5));
          backgroundColor = AppColors.surface;
        } else {
          border = Border.all(color: AppColors.border);
          backgroundColor = AppColors.surface;
        }

        return Container(
          width: 48,
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: border,
          ),
          alignment: Alignment.center,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace &&
                  _controllers[index].text.isEmpty &&
                  index > 0) {
                _focusNodes[index - 1].requestFocus();
                _controllers[index - 1].clear();
                widget.onChanged(currentPin);
                setState(() {});
              }
            },
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              style: AppTextStyles.titleLg.copyWith(
                color: widget.hasError ? AppColors.error : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (val) => _onDigitChanged(index, val),
            ),
          ),
        );
      }),
    );
  }
}
