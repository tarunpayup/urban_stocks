import 'dart:async';
import 'dart:core';

import 'package:stock_market/core/constants/api_constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketClient{
  WebSocketChannel? _channel;
  Future<void> connect() async{
    final uri = Uri.parse(
      ApiConstants.websocketUrl
    );

    _channel = WebSocketChannel.connect(uri);

    await _channel!.ready;
  }
  Stream<dynamic> get stream{
    if(_channel == null){
      throw Exception("Websocket is not connected");
    }
    return _channel!.stream;
  }
  void send(dynamic message){
    _channel?.sink.add(message);
  }

  Future<void> disconnect() async{
    await _channel?.sink.close();
    _channel = null;
  }
}