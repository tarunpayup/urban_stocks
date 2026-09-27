import 'package:stock_market/features/market/domain/entities/tick.dart';

class TickModel extends Tick{
  const TickModel({
    required super.symbol,
    required super.price,
    required super.volume
  });

  factory TickModel.fromJson(
    Map<String,dynamic> json
  ){
    return TickModel(
      symbol: json['symbol'].toString(), 
      price: (json['price'] as num).toDouble(), 
      volume: (json['volume'] as num).toInt()
      );
  }
}