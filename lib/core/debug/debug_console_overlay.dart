import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/debug/debug_console_panel.dart';
import 'package:vstech_home_services/core/debug/debug_log_store.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Wraps the whole app (from `MaterialApp.builder`) with a draggable "Debug" button that opens the
/// [DebugConsolePanel] on top of any screen. Only mounted when `DEBUG_CONSOLE` is on, so testers'
/// builds have it and production builds don't.
class DebugConsoleOverlay extends StatefulWidget {
  const DebugConsoleOverlay({required this.child, this.store, super.key});

  final Widget child;

  /// Defaults to [DebugLogStore.instance].
  final DebugLogStore? store;

  @override
  State<DebugConsoleOverlay> createState() => _DebugConsoleOverlayState();
}

class _DebugConsoleOverlayState extends State<DebugConsoleOverlay> {
  Offset? _position;
  bool _open = false;

  DebugLogStore get _store => widget.store ?? DebugLogStore.instance;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final position =
            _position ??
            Offset(size.width - 112, size.height - padding.bottom - 200);
        return Stack(
          children: [
            widget.child,
            if (!_open)
              Positioned(
                left: position.dx,
                top: position.dy,
                child: GestureDetector(
                  onPanUpdate: (details) => setState(() {
                    final next = position + details.delta;
                    _position = Offset(
                      next.dx.clamp(0, size.width - 96),
                      next.dy.clamp(
                        padding.top,
                        size.height - padding.bottom - 48,
                      ),
                    );
                  }),
                  child: _DebugButton(
                    store: _store,
                    onTap: () => setState(() => _open = true),
                  ),
                ),
              ),
            if (_open)
              Positioned.fill(
                // Own Overlay so text selection, snack bars and tooltips work above the router.
                child: Overlay(
                  initialEntries: [
                    OverlayEntry(
                      builder: (_) => DebugConsolePanel(
                        store: _store,
                        onClose: () => setState(() => _open = false),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Icon + label pill; a red count shows failed HTTP calls so testers notice problems.
class _DebugButton extends StatelessWidget {
  const _DebugButton({required this.store, required this.onTap});

  final DebugLogStore store;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final failures = store.calls.where((call) => call.isError).length;
        return Material(
          key: const Key('debug_console_button'),
          color: AppColors.surface,
          shape: StadiumBorder(
            side: BorderSide(
              color: failures > 0 ? AppColors.error : AppColors.border,
            ),
          ),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onTap,
            child: Container(
              constraints: const BoxConstraints(minHeight: 48),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bug_report_outlined,
                    size: 20,
                    color: failures > 0
                        ? AppColors.error
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    failures > 0
                        ? '${context.l10n.debugOpen} · $failures'
                        : context.l10n.debugOpen,
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: failures > 0
                          ? AppColors.error
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
