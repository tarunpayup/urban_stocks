import 'package:stock_market/features/market/domain/entities/candle.dart';

class CandleModels extends Candle{
  const CandleModels({
    required super.time,
    required super.open,
    required super.high,
    required super.low,
    required super.close,
    required super.volume
  });

  factory CandleModels.fromJson(
    Map<String,dynamic> json,
  ){
    return CandleModels(
      time: DateTime.parse(json['time']), 
      open: (json['open'] as num).toDouble(), 
      high: (json['high'] as num).toDouble(), 
      low: (json['low'] as num).toDouble(), 
      close: (json['close'] as num).toDouble(), 
      volume: (json['volume'] as num).toInt()
      );
  }
}