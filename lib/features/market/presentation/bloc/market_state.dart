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

  const MarketState({
    this.status = MarketStatus.initial,
    this.candles = const [],
    this.currentPrice,
    this.errorMessage,
  });

  MarketState copyWith({
    MarketStatus? status,
    List<Candle>? candles,
    double? currentPrice,
    String? errorMessage,
  }) {
    return MarketState(
      status: status ?? this.status,
      candles: candles ?? this.candles,
      currentPrice: currentPrice ?? this.currentPrice,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        candles,
        currentPrice,
        errorMessage,
      ];
}