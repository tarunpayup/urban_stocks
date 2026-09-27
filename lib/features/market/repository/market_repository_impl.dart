
import 'package:stock_market/features/market/data/datasource/market_api_datasource.dart';
import 'package:stock_market/features/market/data/datasource/market_websocket_datasource.dart';
import 'package:stock_market/features/market/domain/entities/candle.dart';
import 'package:stock_market/features/market/domain/entities/tick.dart';
import 'package:stock_market/features/market/repository/market_repository.dart';

class MarketRepositoryImpl implements MarketRepository{
    final MarketApiDatasource apiDatasource;
    final MarketWebsocketDatasource websocketDatasource;
    MarketRepositoryImpl({
      required this.apiDatasource,
      required this.websocketDatasource,
    });

    @override
    Future<List<Candle>> getHistoricalCandles(){
      return apiDatasource.getCandles();
    }

    @override
    Future<void> connectWebSocket(){
      return websocketDatasource.connect();
    }

    Stream<Tick> getLiveTicks(){
      return websocketDatasource.ticks();
    }

    @override
    Future<void> disconnectWebSocket(){
      return websocketDatasource.disconnect();
    }

  @override
  Stream<Tick> getLiveTick() {
    // TODO: implement getLiveTick
    throw UnimplementedError();
  }
  }
