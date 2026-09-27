import 'package:equatable/equatable.dart';

abstract class MarketEvent extends Equatable {
  const MarketEvent();

  @override
  List<Object?> get props => [];
}

/// Load historical candle data using Dio
class LoadMarketData extends MarketEvent {
  const LoadMarketData();
}

/// Connect to WebSocket
class ConnectMarketStream extends MarketEvent {
  const ConnectMarketStream();
}

/// A new tick has arrived from WebSocket
class TickReceived extends MarketEvent {
  final dynamic tick;

  const TickReceived(this.tick);

  @override
  List<Object?> get props => [tick];
}

/// Disconnect WebSocket
class DisconnectMarketStream extends MarketEvent {
  const DisconnectMarketStream();
}