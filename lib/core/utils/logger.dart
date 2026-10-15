import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:vstech_home_services/core/config/app_env.dart';
import 'package:vstech_home_services/core/debug/debug_log_store.dart';

/// Three colour-coded log channels so app, network and BLoC output are easy to tell apart in the
/// `flutter run` / VS Code / Android Studio console (Xcode's console does not render ANSI colours).
/// Use these instead of `print()` anywhere in the codebase.
///
/// Logging is on in debug/profile builds and off in release — unless `DEBUG_CONSOLE=true`, which
/// keeps it on and also feeds the in-app debug console (`DebugLogStore`). Lower the noise with
/// `--dart-define=LOG_LEVEL=info` (trace | debug | info | warning | error | off).

/// General app logs, coloured by severity: trace grey · debug blue · info green · warning orange ·
/// error red · fatal magenta.
final Logger appLogger = Logger(
  filter: AppLogFilter(),
  printer: appLogPrinter,
  output: _withDebugConsole(DebugLogSource.app),
);

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
  output: _withDebugConsole(DebugLogSource.bloc),
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

/// Console output, plus the debug console store when `DEBUG_CONSOLE` is on. HTTP calls reach the
/// store in structured form through `NetworkLogInterceptor`, so [networkLogger] stays console-only.
LogOutput _withDebugConsole(DebugLogSource source) => AppEnv.debugConsoleEnabled
    ? MultiOutput([ConsoleOutput(), DebugStoreOutput(source)])
    : ConsoleOutput();

/// Copies each log event (plain message, no ANSI / box drawing) into a [DebugLogStore].
class DebugStoreOutput extends LogOutput {
  DebugStoreOutput(this.source, {DebugLogStore? store})
    : _store = store ?? DebugLogStore.instance;

  final DebugLogSource source;
  final DebugLogStore _store;

  @override
  void output(OutputEvent event) {
    final origin = event.origin;
    final error = origin.error;
    _store.addLog(
      DebugLogEntry(
        time: origin.time,
        source: source,
        level: toDebugLevel(origin.level),
        message: error == null
            ? '${origin.message}'
            : '${origin.message}\n$error',
      ),
    );
  }

  @visibleForTesting
  static DebugLogLevel toDebugLevel(Level level) => switch (level) {
    Level.debug => DebugLogLevel.debug,
    Level.info => DebugLogLevel.info,
    Level.warning => DebugLogLevel.warning,
    Level.error || Level.fatal => DebugLogLevel.error,
    _ => DebugLogLevel.trace,
  };
}

/// Logs everything at or above `LOG_LEVEL` (default: trace) when [AppEnv.loggingEnabled].
class AppLogFilter extends LogFilter {
  AppLogFilter({bool? enabled, Level? minLevel})
    : _enabled = enabled ?? AppEnv.loggingEnabled,
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
