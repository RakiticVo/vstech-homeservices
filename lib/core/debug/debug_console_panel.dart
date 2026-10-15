import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/config/app_env.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/debug/debug_log_store.dart';
import 'package:vstech_home_services/core/di/injection.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Full-screen tester console: Network (each HTTP call with status, timing, masked bodies),
/// Logs (app / BLoC / uncaught errors, filterable by level) and Info (environment, API, session).
/// "Copy all" puts a plain-text dump on the clipboard for bug reports.
class DebugConsolePanel extends StatelessWidget {
  const DebugConsolePanel({
    required this.store,
    required this.onClose,
    super.key,
  });

  final DebugLogStore store;
  final VoidCallback onClose;

  void _copy(BuildContext context, String text) {
    unawaited(Clipboard.setData(ClipboardData(text: text)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.debugCopied)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: const Key('debug_console_panel'),
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            l10n.debugConsoleTitle,
            style: AppTextStyles.headlineSmall.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: AppSecondaryButton(
                key: const Key('debug_console_close'),
                label: l10n.debugClose,
                icon: Icons.close_rounded,
                onPressed: onClose,
              ),
            ),
          ],
          bottom: TabBar(
            dividerColor: AppColors.border,
            labelColor: AppColors.primaryPressed,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(
                icon: const Icon(Icons.swap_vert_rounded),
                text: l10n.debugTabNetwork,
              ),
              Tab(
                icon: const Icon(Icons.notes_rounded),
                text: l10n.debugTabLogs,
              ),
              Tab(
                icon: const Icon(Icons.info_outline_rounded),
                text: l10n.debugTabInfo,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppSecondaryButton(
                      key: const Key('debug_copy_all'),
                      label: l10n.debugCopyAll,
                      icon: Icons.copy_all_rounded,
                      isFullWidth: true,
                      onPressed: () => _copy(
                        context,
                        store.export(header: _infoText(context)),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  AppSecondaryButton(
                    key: const Key('debug_clear'),
                    label: l10n.debugClear,
                    icon: Icons.delete_outline_rounded,
                    textColor: AppColors.error,
                    onPressed: store.clear,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: store,
                builder: (context, _) => TabBarView(
                  children: [
                    _NetworkTab(
                      calls: store.calls,
                      onCopy: (text) => _copy(context, text),
                    ),
                    _LogsTab(logs: store.logs),
                    _InfoTab(lines: _infoLines(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static List<(String, String)> _infoLines(BuildContext context) {
    final l10n = context.l10n;
    final session = getIt.isRegistered<SessionCubit>()
        ? getIt<SessionCubit>().state
        : null;
    return [
      (l10n.debugInfoEnv, AppEnv.name),
      (l10n.debugInfoApi, AppEnv.apiBaseUrl),
      (l10n.debugInfoWs, AppEnv.wsBaseUrl),
      (
        l10n.debugInfoBuild,
        kReleaseMode ? 'release' : (kProfileMode ? 'profile' : 'debug'),
      ),
      (
        l10n.debugInfoPlatform,
        kIsWeb
            ? 'web'
            : '${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
      ),
      (l10n.debugInfoLocale, Localizations.localeOf(context).toLanguageTag()),
      (
        l10n.debugInfoSession,
        switch (session) {
          SessionAuthenticatedState(:final role) =>
            'authenticated · ${role?.name ?? '-'}',
          SessionUnauthenticatedState(:final expired) =>
            expired ? 'signed out (expired)' : 'signed out',
          _ => '-',
        },
      ),
    ];
  }

  static String _infoText(BuildContext context) => [
    '=== INFO ===',
    for (final (label, value) in _infoLines(context)) '$label: $value',
  ].join('\n');
}

String _time(DateTime time) => DateFormat('HH:mm:ss').format(time.toLocal());

class _NetworkTab extends StatefulWidget {
  const _NetworkTab({required this.calls, required this.onCopy});

  final List<DebugNetworkCall> calls;
  final ValueChanged<String> onCopy;

  @override
  State<_NetworkTab> createState() => _NetworkTabState();
}

class _NetworkTabState extends State<_NetworkTab> {
  int? _selectedId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selected = widget.calls
        .where((call) => call.id == _selectedId)
        .firstOrNull;
    if (selected != null) {
      return _CallDetail(
        call: selected,
        onBack: () => setState(() => _selectedId = null),
        onCopy: widget.onCopy,
      );
    }
    if (widget.calls.isEmpty) return _Empty(text: l10n.debugEmpty);
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: widget.calls.length,
      itemBuilder: (context, index) {
        final call = widget.calls[index];
        final uri = Uri.tryParse(call.url);
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Material(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.control),
              side: BorderSide(
                color: call.isError ? AppColors.error : AppColors.border,
              ),
            ),
            child: InkWell(
              key: Key('debug_call_${call.id}'),
              borderRadius: BorderRadius.circular(AppRadius.control),
              onTap: () => setState(() => _selectedId = call.id),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Row(
                  children: [
                    _StatusBadge(call: call),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${call.method} ${uri?.path ?? call.url}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.labelMedium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            [
                              _time(call.startedAt),
                              if (call.durationMs != null)
                                '${call.durationMs}ms',
                              if (call.errorCode != null) call.errorCode!,
                            ].join(' · '),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Status as Icon + Label + Color: pending, 2xx, 4xx, 5xx / transport failure.
class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.call});

  final DebugNetworkCall call;

  @override
  Widget build(BuildContext context) {
    final status = call.statusCode;
    final (IconData icon, Color color, String label) = !call.isFinished
        ? (Icons.hourglass_empty_rounded, AppColors.textSecondary, '…')
        : status == null
        ? (Icons.cloud_off_rounded, AppColors.error, context.l10n.debugError)
        : status < 300
        ? (Icons.check_circle_outline_rounded, AppColors.successDark, '$status')
        : status < 500
        ? (Icons.warning_amber_rounded, AppColors.warning, '$status')
        : (Icons.error_outline_rounded, AppColors.error, '$status');
    return SizedBox(
      width: 56,
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _CallDetail extends StatelessWidget {
  const _CallDetail({
    required this.call,
    required this.onBack,
    required this.onCopy,
  });

  final DebugNetworkCall call;
  final VoidCallback onBack;
  final ValueChanged<String> onCopy;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final summary = [
      '${call.method} ${call.url}',
      [
        '${call.statusCode ?? call.errorMessage ?? l10n.debugPending}',
        if (call.durationMs != null) '${call.durationMs}ms',
        if (call.errorCode != null) call.errorCode!,
      ].join(' · '),
    ].join('\n');
    final sections = [
      (l10n.debugHeaders, call.requestHeaders),
      (l10n.debugRequest, call.requestBody),
      (
        l10n.debugResponse,
        call.responseBody ?? (call.isFinished ? null : l10n.debugPending),
      ),
    ];
    final all = [
      summary,
      for (final (title, body) in sections)
        if (body != null) '$title:\n$body',
    ].join('\n\n');

    return ListView(
      key: const Key('debug_call_detail'),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          children: [
            Expanded(
              child: AppSecondaryButton(
                label: l10n.debugBack,
                icon: Icons.arrow_back_rounded,
                isFullWidth: true,
                onPressed: onBack,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppSecondaryButton(
                label: l10n.debugCopy,
                icon: Icons.copy_rounded,
                isFullWidth: true,
                onPressed: () => onCopy(all),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            _StatusBadge(call: call),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _Mono(summary)),
          ],
        ),
        for (final (title, body) in sections)
          if (body != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.control),
                border: Border.all(color: AppColors.border),
              ),
              child: _Mono(body),
            ),
          ],
      ],
    );
  }
}

enum _LogFilter { all, warnings, errors }

class _LogsTab extends StatefulWidget {
  const _LogsTab({required this.logs});

  final List<DebugLogEntry> logs;

  @override
  State<_LogsTab> createState() => _LogsTabState();
}

class _LogsTabState extends State<_LogsTab> {
  _LogFilter _filter = _LogFilter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final logs = [
      for (final log in widget.logs)
        if (switch (_filter) {
          _LogFilter.all => true,
          _LogFilter.warnings => log.level.index >= DebugLogLevel.warning.index,
          _LogFilter.errors => log.level == DebugLogLevel.error,
        })
          log,
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            0,
          ),
          child: Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final (filter, label) in [
                (_LogFilter.all, l10n.debugFilterAll),
                (_LogFilter.warnings, l10n.debugFilterWarnings),
                (_LogFilter.errors, l10n.debugFilterErrors),
              ])
                ChoiceChip(
                  key: Key('debug_log_filter_${filter.name}'),
                  label: Text(label),
                  selected: _filter == filter,
                  showCheckmark: true,
                  selectedColor: AppColors.secondarySurface,
                  backgroundColor: AppColors.surface,
                  side: BorderSide(
                    color: _filter == filter
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                  onSelected: (_) => setState(() => _filter = filter),
                ),
            ],
          ),
        ),
        Expanded(
          child: logs.isEmpty
              ? _Empty(text: l10n.debugEmpty)
              : ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: logs.length,
                  itemBuilder: (context, index) => _LogTile(log: logs[index]),
                ),
        ),
      ],
    );
  }
}

class _LogTile extends StatefulWidget {
  const _LogTile({required this.log});

  final DebugLogEntry log;

  @override
  State<_LogTile> createState() => _LogTileState();
}

class _LogTileState extends State<_LogTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final log = widget.log;
    final (IconData icon, Color color) = switch (log.level) {
      DebugLogLevel.error => (Icons.error_outline_rounded, AppColors.error),
      DebugLogLevel.warning => (Icons.warning_amber_rounded, AppColors.warning),
      DebugLogLevel.info => (Icons.info_outline_rounded, AppColors.successDark),
      DebugLogLevel.debug ||
      DebugLogLevel.trace => (Icons.circle_outlined, AppColors.textMuted),
    };
    return InkWell(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_time(log.time)} · ${log.level.name.toUpperCase()} · ${log.source.name}',
                    style: AppTextStyles.caption.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  _Mono(log.message, maxLines: _expanded ? null : 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTab extends StatelessWidget {
  const _InfoTab({required this.lines});

  final List<(String, String)> lines;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(AppSpacing.md),
    children: [
      for (final (label, value) in lines)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              _Mono(value),
            ],
          ),
        ),
      const SizedBox(height: AppSpacing.sm),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              context.l10n.debugInfoPrivacy,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

/// Monospace text. Selectable when shown in full; a collapsed preview ([maxLines]) is plain text
/// because `SelectableText` reserves the height of all [maxLines].
class _Mono extends StatelessWidget {
  const _Mono(this.text, {this.maxLines});

  final String text;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.caption.copyWith(
      color: AppColors.textPrimary,
      fontFamily: 'monospace',
      height: 1.4,
    );
    return maxLines == null
        ? SelectableText(text, style: style)
        : Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: style,
          );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.inbox_outlined, size: 24, color: AppColors.textMuted),
        const SizedBox(height: AppSpacing.sm),
        Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}
