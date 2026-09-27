
import 'package:stock_market/features/market/domain/entities/candle.dart';
import 'package:stock_market/features/market/domain/entities/tick.dart';

abstract class MarketRepository {
  Future<List<Candle>> getHistoricalCandles();
  Future<void> connectWebSocket();
  Stream<Tick> getLiveTick();
  Future<void> disconnectWebSocket();
}