import 'dart:collection';

import 'package:flutter/foundation.dart';

/// Where a log line came from.
enum DebugLogSource { app, network, bloc }

/// Severity, mirroring the `logger` package levels the app uses.
enum DebugLogLevel { trace, debug, info, warning, error }

/// One log line kept for the in-app debug console.
@immutable
class DebugLogEntry {
  const DebugLogEntry({
    required this.time,
    required this.source,
    required this.level,
    required this.message,
  });

  final DateTime time;
  final DebugLogSource source;
  final DebugLogLevel level;
  final String message;
}

/// One HTTP call as seen by `NetworkLogInterceptor`. Bodies and headers are already redacted
/// (tokens / passwords masked) before they get here.
@immutable
class DebugNetworkCall {
  const DebugNetworkCall({
    required this.id,
    required this.method,
    required this.url,
    required this.startedAt,
    this.requestHeaders,
    this.requestBody,
    this.statusCode,
    this.durationMs,
    this.responseBody,
    this.errorCode,
    this.errorMessage,
    this.isFinished = false,
  });

  final int id;
  final String method;
  final String url;
  final DateTime startedAt;
  final String? requestHeaders;
  final String? requestBody;
  final int? statusCode;
  final int? durationMs;
  final String? responseBody;

  /// `HS-XXX-XXXX` from the error envelope, if any.
  final String? errorCode;

  /// Transport failure (timeout, no connection…) when there is no response.
  final String? errorMessage;
  final bool isFinished;

  bool get isError => isFinished && (statusCode == null || statusCode! >= 400);

  DebugNetworkCall finish({
    int? statusCode,
    int? durationMs,
    String? responseBody,
    String? errorCode,
    String? errorMessage,
  }) => DebugNetworkCall(
    id: id,
    method: method,
    url: url,
    startedAt: startedAt,
    requestHeaders: requestHeaders,
    requestBody: requestBody,
    statusCode: statusCode,
    durationMs: durationMs,
    responseBody: responseBody,
    errorCode: errorCode,
    errorMessage: errorMessage,
    isFinished: true,
  );
}

/// In-memory ring buffer behind the debug console: the last [maxLogs] log lines and [maxCalls]
/// HTTP calls of this app session. Nothing is written to disk or sent anywhere.
class DebugLogStore extends ChangeNotifier {
  DebugLogStore({this.maxLogs = 500, this.maxCalls = 200});

  /// The app-wide store fed by the loggers and the network interceptor.
  static final DebugLogStore instance = DebugLogStore();

  final int maxLogs;
  final int maxCalls;

  final ListQueue<DebugLogEntry> _logs = ListQueue();
  final ListQueue<DebugNetworkCall> _calls = ListQueue();
  int _nextCallId = 0;

  /// Newest first.
  List<DebugLogEntry> get logs =>
      _logs.toList().reversed.toList(growable: false);

  /// Newest first.
  List<DebugNetworkCall> get calls =>
      _calls.toList().reversed.toList(growable: false);

  void addLog(DebugLogEntry entry) {
    _logs.addLast(entry);
    while (_logs.length > maxLogs) {
      _logs.removeFirst();
    }
    notifyListeners();
  }

  /// Records the start of a call and returns its id for [finishCall].
  int startCall({
    required String method,
    required String url,
    String? requestHeaders,
    String? requestBody,
  }) {
    final id = _nextCallId++;
    _calls.addLast(
      DebugNetworkCall(
        id: id,
        method: method,
        url: url,
        startedAt: DateTime.now(),
        requestHeaders: requestHeaders,
        requestBody: requestBody,
      ),
    );
    while (_calls.length > maxCalls) {
      _calls.removeFirst();
    }
    notifyListeners();
    return id;
  }

  void finishCall(
    int id, {
    int? statusCode,
    int? durationMs,
    String? responseBody,
    String? errorCode,
    String? errorMessage,
  }) {
    final index = _calls.toList().indexWhere((call) => call.id == id);
    if (index < 0) return;
    final updated = _calls
        .elementAt(index)
        .finish(
          statusCode: statusCode,
          durationMs: durationMs,
          responseBody: responseBody,
          errorCode: errorCode,
          errorMessage: errorMessage,
        );
    final list = _calls.toList()..[index] = updated;
    _calls
      ..clear()
      ..addAll(list);
    notifyListeners();
  }

  void clear() {
    _logs.clear();
    _calls.clear();
    notifyListeners();
  }

  /// Plain-text dump (oldest first) for "Copy all", so a tester can paste it to the team.
  String export({String header = ''}) {
    final buffer = StringBuffer();
    if (header.isNotEmpty) buffer.writeln(header);
    buffer.writeln('=== NETWORK (${_calls.length}) ===');
    for (final call in _calls) {
      buffer
        ..writeln(
          '[${call.startedAt.toIso8601String()}] ${call.method} ${call.url} → '
          '${call.statusCode ?? call.errorMessage ?? '…'}${call.durationMs == null ? '' : ' (${call.durationMs}ms)'}'
          '${call.errorCode == null ? '' : ' ${call.errorCode}'}',
        )
        ..writeAll([
          if (call.requestBody != null) '  request: ${call.requestBody}\n',
          if (call.responseBody != null) '  response: ${call.responseBody}\n',
        ]);
    }
    buffer.writeln('=== LOGS (${_logs.length}) ===');
    for (final log in _logs) {
      buffer.writeln(
        '[${log.time.toIso8601String()}] ${log.level.name.toUpperCase()} ${log.source.name}: ${log.message}',
      );
    }
    return buffer.toString();
  }
}
