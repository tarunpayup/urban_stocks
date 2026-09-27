import 'package:equatable/equatable.dart';

import '../../domain/entities/candle.dart';

enum MarketStatus {
  initial,
  loading,
  loaded,
  connecting,
  connected,
  disconnected,
  error,
}

class MarketState extends Equatable {
  final MarketStatus status;

  final List<Candle> candles;

  final double? currentPrice;

  final String? errorMessage;

  // Fixed chart axis bounds computed from the full candle
  // set so the chart doesn't rescale as candles are revealed.
  final double? minY;

  final double? maxY;

  final DateTime? minX;

  final DateTime? maxX;

  const MarketState({
    this.status = MarketStatus.initial,
    this.candles = const [],
    this.currentPrice,
    this.errorMessage,
    this.minY,
    this.maxY,
    this.minX,
    this.maxX,
  });

  MarketState copyWith({
    MarketStatus? status,
    List<Candle>? candles,
    double? currentPrice,
    String? errorMessage,
    double? minY,
    double? maxY,
    DateTime? minX,
    DateTime? maxX,
  }) {
    return MarketState(
      status: status ?? this.status,
      candles: candles ?? this.candles,
      currentPrice: currentPrice ?? this.currentPrice,
      errorMessage: errorMessage,
      minY: minY ?? this.minY,
      maxY: maxY ?? this.maxY,
      minX: minX ?? this.minX,
      maxX: maxX ?? this.maxX,
    );
  }

  @override
  List<Object?> get props => [
        status,
        candles,
        currentPrice,
        errorMessage,
        minY,
        maxY,
        minX,
        maxX,
      ];
}