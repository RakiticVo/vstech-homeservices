import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:vstech_home_services/core/utils/logger.dart';

LogEvent _event(Level level) => LogEvent(level, 'm');

/// Matches an ANSI 256-colour foreground escape, e.g. `\x1B[38;5;46m`.
final _ansiFg = RegExp(r'\x1B\[38;5;(\d+)m');

/// Foreground colour codes in what [printer] renders for a [level] event.
Set<int> _colours(LogPrinter printer, Level level) => {
  for (final line in printer.log(LogEvent(level, 'hello')))
    for (final match in _ansiFg.allMatches(line)) int.parse(match.group(1)!),
};

void main() {
  group('log output is coloured', () {
    test('app channel: one distinct colour per severity', () {
      final colours = [
        for (final level in [Level.debug, Level.info, Level.warning, Level.error]) _colours(appLogPrinter, level),
      ];
      expect(colours.every((c) => c.length == 1), isTrue, reason: '$colours');
      expect(colours.expand((c) => c).toSet(), hasLength(4));
    });

    test('network channel: request, 2xx, 4xx and errors each have their own colour', () {
      expect(_colours(networkLogPrinter, Level.debug), {51});
      expect(_colours(networkLogPrinter, Level.info), {46});
      expect(_colours(networkLogPrinter, Level.warning), {214});
      expect(_colours(networkLogPrinter, Level.error), {196});
    });

    test('bloc channel: state changes are purple, errors red', () {
      expect(_colours(blocLogPrinter, Level.debug), {141});
      expect(_colours(blocLogPrinter, Level.error), {196});
    });
  });

  test('parseLogLevel understands the LOG_LEVEL values and defaults to trace', () {
    expect(parseLogLevel('INFO'), Level.info);
    expect(parseLogLevel('warning'), Level.warning);
    expect(parseLogLevel('off'), Level.off);
    expect(parseLogLevel(''), Level.trace);
    expect(parseLogLevel('nonsense'), Level.trace);
  });

  test('AppLogFilter respects the minimum level', () {
    final filter = AppLogFilter(enabled: true, minLevel: Level.info);
    expect(filter.shouldLog(_event(Level.debug)), isFalse);
    expect(filter.shouldLog(_event(Level.info)), isTrue);
    expect(filter.shouldLog(_event(Level.error)), isTrue);
  });

  test('AppLogFilter logs nothing when disabled (release builds)', () {
    final filter = AppLogFilter(enabled: false);
    expect(filter.shouldLog(_event(Level.fatal)), isFalse);
  });
}
