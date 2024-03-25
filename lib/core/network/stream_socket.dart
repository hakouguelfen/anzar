import 'dart:async';

class StreamSocket {
  final _socketResponse = StreamController<String>.broadcast();

  void addResponse(String msg) {
    _socketResponse.sink.add(msg);
  }

  Stream<String> get getResponse => _socketResponse.stream;

  Future<void> dispose() async {
    await _socketResponse.close();
  }
}

class OrderStream extends StreamSocket {}

class ShopStream extends StreamSocket {}
