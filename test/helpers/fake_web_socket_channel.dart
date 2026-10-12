import 'dart:async';

import 'package:stream_channel/stream_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// In-memory [WebSocketChannel]: push server frames with [serverSend], read what the client sent
/// from [sent], end the connection with [serverClose].
class FakeWebSocketChannel
    with StreamChannelMixin<dynamic>
    implements WebSocketChannel {
  FakeWebSocketChannel({bool failHandshake = false}) {
    if (failHandshake) {
      _ready.completeError(WebSocketChannelException('handshake failed'));
      unawaited(_ready.future.catchError((_) {}));
    } else {
      _ready.complete();
    }
  }

  final StreamController<dynamic> _incoming = StreamController<dynamic>();
  final Completer<void> _ready = Completer<void>();
  final List<dynamic> sent = [];
  late final _FakeSink _sink = _FakeSink(sent);

  bool get isClosedByClient => _sink.closed;

  void serverSend(String frame) => _incoming.add(frame);

  Future<void> serverClose() => _incoming.close();

  @override
  Stream<dynamic> get stream => _incoming.stream;

  @override
  WebSocketSink get sink => _sink;

  @override
  Future<void> get ready => _ready.future;

  @override
  String? get protocol => null;

  @override
  int? get closeCode => null;

  @override
  String? get closeReason => null;
}

class _FakeSink implements WebSocketSink {
  _FakeSink(this.sent);

  final List<dynamic> sent;
  bool closed = false;

  @override
  void add(dynamic data) => sent.add(data);

  @override
  void addError(Object error, [StackTrace? stackTrace]) {}

  @override
  Future<void> addStream(Stream<dynamic> stream) => stream.forEach(add);

  @override
  Future<void> close([int? closeCode, String? closeReason]) async =>
      closed = true;

  @override
  Future<void> get done => Future.value();
}
