// Private fields are assigned from public named params (see ApiClient).
// ignore_for_file: prefer_initializing_formals

import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/config/app_env.dart';
import 'package:vstech_home_services/core/network/auth_token_store.dart';
import 'package:vstech_home_services/core/utils/logger.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Opens a raw channel; swapped out in tests.
typedef WebSocketConnector = WebSocketChannel Function(
  Uri uri,
  Map<String, String> headers,
);

enum RealtimeSocketStatus { connecting, connected, reconnecting, closed }

/// Plain-JSON WebSocket used by chat / tracking (`docs/reference/api/07-chat.md` §2): the access
/// token goes in the `Authorization` handshake header, no STOMP or sub-protocol. Frames are JSON
/// objects in both directions.
///
/// Drops are retried up to [maxReconnectAttempts] times with a linear back-off (2s, 4s, …) and a
/// fresh token each time; the counter resets once a connection is up again. One instance serves
/// one path — create it per feature BLoC and [close] it with the BLoC.
class RealtimeSocket {
  RealtimeSocket({
    required AuthTokenStore tokenStore,
    String? baseUrl,
    WebSocketConnector? connector,
    this.maxReconnectAttempts = 5,
    this.reconnectDelay = _defaultDelay,
  }) : _tokenStore = tokenStore,
       _baseUrl = baseUrl ?? AppEnv.wsBaseUrl,
       _connector = connector ?? _ioConnector;

  final AuthTokenStore _tokenStore;
  final String _baseUrl;
  final WebSocketConnector _connector;
  final int maxReconnectAttempts;
  final Duration Function(int attempt) reconnectDelay;

  final StreamController<Map<String, dynamic>> _messages =
      StreamController.broadcast();
  final StreamController<RealtimeSocketStatus> _status =
      StreamController.broadcast();

  WebSocketChannel? _channel;
  // Cancelled in _dropChannel on every drop and on close.
  // ignore: cancel_subscriptions
  StreamSubscription<dynamic>? _subscription;
  Timer? _reconnectTimer;
  String? _path;
  int _attempts = 0;
  bool _closed = false;
  bool _disposed = false;

  /// Decoded JSON objects received from the server (non-object frames are dropped).
  Stream<Map<String, dynamic>> get messages => _messages.stream;

  Stream<RealtimeSocketStatus> get status => _status.stream;

  static Duration _defaultDelay(int attempt) => Duration(seconds: attempt * 2);

  static WebSocketChannel _ioConnector(Uri uri, Map<String, String> headers) =>
      IOWebSocketChannel.connect(uri, headers: headers);

  /// Connects to [path] (e.g. `/ws/chat/12`) on the configured WebSocket origin.
  Future<void> connect(String path) async {
    _path = path;
    _closed = false;
    _attempts = 0;
    _emitStatus(RealtimeSocketStatus.connecting);
    await _open();
  }

  /// Sends one JSON frame. Returns false when there is no open connection.
  bool send(Map<String, dynamic> frame) {
    final channel = _channel;
    if (channel == null) return false;
    channel.sink.add(jsonEncode(frame));
    return true;
  }

  /// Drops the connection and stops reconnecting, but keeps [messages] / [status] open so [connect]
  /// can be called again — e.g. after the server rejected a subscription and then closed.
  Future<void> disconnect() async {
    if (_disposed || (_closed && _channel == null)) return;
    _closed = true;
    _reconnectTimer?.cancel();
    await _dropChannel();
    networkLogger.i('🔌 WS closed $_path');
    _emitStatus(RealtimeSocketStatus.closed);
  }

  /// [disconnect]s for good and closes the streams. The socket cannot be reused afterwards.
  Future<void> close() async {
    if (_disposed) return;
    await disconnect();
    _disposed = true;
    await _messages.close();
    await _status.close();
  }

  Future<void> _open() async {
    final path = _path;
    if (path == null || _closed) return;
    final token = await _tokenStore.readAccessToken();
    final uri = Uri.parse('$_baseUrl$path');
    try {
      final channel = _connector(uri, {
        if (token != null) 'Authorization': 'Bearer $token',
      });
      _channel = channel;
      _subscription = channel.stream.listen(
        _onFrame,
        onError: _onDrop,
        onDone: _onDrop,
        cancelOnError: true,
      );
      await channel.ready;
      if (_closed) return;
      _attempts = 0;
      networkLogger.i('🔌 WS connected $uri');
      _emitStatus(RealtimeSocketStatus.connected);
    } on Object catch (error) {
      networkLogger.w('🔌 WS connect failed $uri: $error');
      _onDrop();
    }
  }

  void _onFrame(dynamic frame) {
    if (frame is! String) return;
    try {
      final json = jsonDecode(frame);
      if (json is Map<String, dynamic> && !_messages.isClosed) {
        _messages.add(json);
      }
    } on FormatException {
      networkLogger.w('🔌 WS dropped a non-JSON frame on $_path');
    }
  }

  void _onDrop([Object? error]) {
    // A failed handshake reports both through `ready` and the stream — reconnect only once.
    if (_closed || (_reconnectTimer?.isActive ?? false)) return;
    unawaited(_dropChannel());
    if (_attempts >= maxReconnectAttempts) {
      networkLogger.w('🔌 WS gave up on $_path after $_attempts retries');
      _emitStatus(RealtimeSocketStatus.closed);
      return;
    }
    _attempts++;
    _emitStatus(RealtimeSocketStatus.reconnecting);
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(
      reconnectDelay(_attempts),
      () => unawaited(_open()),
    );
  }

  Future<void> _dropChannel() async {
    final subscription = _subscription;
    final channel = _channel;
    _subscription = null;
    _channel = null;
    await subscription?.cancel();
    try {
      await channel?.sink.close();
    } on Object {
      // Already closed by the server.
    }
  }

  void _emitStatus(RealtimeSocketStatus status) {
    if (!_status.isClosed) _status.add(status);
  }
}

/// Creates one [RealtimeSocket] per caller — sockets are never shared between BLoCs.
@lazySingleton
class RealtimeSocketFactory {
  const RealtimeSocketFactory(this._tokenStore);

  final AuthTokenStore _tokenStore;

  RealtimeSocket create() => RealtimeSocket(tokenStore: _tokenStore);
}
