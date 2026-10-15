import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Three colour-coded log channels so app, network and BLoC output are easy to tell apart in the
/// `flutter run` / VS Code / Android Studio console (Xcode's console does not render ANSI colours).
/// Use these instead of `print()` anywhere in the codebase.
///
/// Logging is on in debug/profile builds and off in release. Lower the noise with
/// `--dart-define=LOG_LEVEL=info` (trace | debug | info | warning | error | off).

/// General app logs, coloured by severity: trace grey · debug blue · info green · warning orange ·
/// error red · fatal magenta.
final Logger appLogger = Logger(filter: AppLogFilter(), printer: appLogPrinter);

/// Printer behind [appLogger] (exposed so tests can assert the colours).
final LogPrinter appLogPrinter = PrettyPrinter(
  methodCount: 1,
  dateTimeFormat: DateTimeFormat.onlyTime,
  levelColors: {
    Level.trace: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: const AnsiColor.fg(33),
    Level.info: const AnsiColor.fg(40),
    Level.warning: const AnsiColor.fg(208),
    Level.error: const AnsiColor.fg(196),
    Level.fatal: const AnsiColor.fg(199),
  },
);

/// HTTP traffic (see `NetworkLogInterceptor`): request ➡️ cyan · 2xx ✅ green · 4xx ⚠️ orange ·
/// 5xx / transport ❌ red.
final Logger networkLogger = Logger(
  filter: AppLogFilter(),
  printer: networkLogPrinter,
);

/// Printer behind [networkLogger].
final LogPrinter networkLogPrinter = PrettyPrinter(
  methodCount: 0,
  errorMethodCount: 0,
  dateTimeFormat: DateTimeFormat.onlyTime,
  levelColors: const {
    Level.debug: AnsiColor.fg(51),
    Level.info: AnsiColor.fg(46),
    Level.warning: AnsiColor.fg(214),
    Level.error: AnsiColor.fg(196),
  },
  levelEmojis: const {
    Level.debug: '➡️',
    Level.info: '✅',
    Level.warning: '⚠️',
    Level.error: '❌',
  },
);

/// Cubit/BLoC state transitions (see `AppBlocObserver`): change 🧩 purple · error 💥 red.
final Logger blocLogger = Logger(
  filter: AppLogFilter(),
  printer: blocLogPrinter,
);

/// Printer behind [blocLogger].
final LogPrinter blocLogPrinter = PrettyPrinter(
  methodCount: 0,
  dateTimeFormat: DateTimeFormat.onlyTime,
  noBoxingByDefault: true,
  levelColors: const {
    Level.debug: AnsiColor.fg(141),
    Level.error: AnsiColor.fg(196),
  },
  levelEmojis: const {Level.debug: '🧩', Level.error: '💥'},
);

/// Logs everything at or above `LOG_LEVEL` (default: trace) except in release builds.
class AppLogFilter extends LogFilter {
  AppLogFilter({bool? enabled, Level? minLevel})
    : _enabled = enabled ?? !kReleaseMode,
      _minLevel =
          minLevel ?? parseLogLevel(const String.fromEnvironment('LOG_LEVEL'));

  final bool _enabled;
  final Level _minLevel;

  @override
  bool shouldLog(LogEvent event) =>
      _enabled && event.level.value >= _minLevel.value;
}

/// Parses the `LOG_LEVEL` dart-define; unknown or empty values mean [Level.trace].
@visibleForTesting
Level parseLogLevel(String value) => switch (value.toLowerCase()) {
  'debug' => Level.debug,
  'info' => Level.info,
  'warning' => Level.warning,
  'error' => Level.error,
  'off' => Level.off,
  _ => Level.trace,
};
