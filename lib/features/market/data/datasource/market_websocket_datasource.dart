import 'dart:convert';
import '../../../../core/network/websocket_client.dart';
import '../models/tick_model.dart';

class MarketWebsocketDatasource {
  final WebsocketClient client;

  MarketWebsocketDatasource({required this.client});

  Future<void> connect() async{
    await client.connect();
  }

  Stream<TickModel> ticks(){
    return client.stream.map(
      (data){
        final json = jsonDecode(data);
        return TickModel.fromJson(json);
      }
    );
  }

  Future<void> disconnect() async{
    await client.disconnect();
  }
}