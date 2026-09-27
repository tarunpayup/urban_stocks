import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/features/market/repository/market_repository.dart';

import '../../domain/entities/tick.dart';


import 'market_event.dart';
import 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final MarketRepository repository;

  StreamSubscription<Tick>? _tickSubscription;

  MarketBloc({
    required this.repository,
  }) : super(const MarketState()) {
    // Load historical candle data
    on<LoadMarketData>(
      _onLoadMarketData,
    );

    // Connect to WebSocket
    on<ConnectMarketStream>(
      _onConnectMarketStream,
    );

    // Process incoming WebSocket tick
    on<TickReceived>(
      _onTickReceived,
    );

    // Disconnect WebSocket
    on<DisconnectMarketStream>(
      _onDisconnectMarketStream,
    );
  }

  // ============================================================
  // LOAD HISTORICAL MARKET DATA
  // ============================================================

  Future<void> _onLoadMarketData(
    LoadMarketData event,
    Emitter<MarketState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: MarketStatus.loading,
          errorMessage: null,
        ),
      );

      final candles =
          await repository.getHistoricalCandles();

      emit(
        state.copyWith(
          status: MarketStatus.loaded,
          candles: candles,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MarketStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // CONNECT TO WEBSOCKET
  // ============================================================

  Future<void> _onConnectMarketStream(
    ConnectMarketStream event,
    Emitter<MarketState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: MarketStatus.connecting,
          errorMessage: null,
        ),
      );

      // Connect WebSocket
      await repository.connectWebSocket();

      emit(
        state.copyWith(
          status: MarketStatus.connected,
          errorMessage: null,
        ),
      );

      // Cancel previous subscription if any
      await _tickSubscription?.cancel();

      // Listen to incoming WebSocket ticks
      _tickSubscription =
          repository.getLiveTick().listen(
        (tick) {
          add(
            TickReceived(tick),
          );
        },
        onError: (error) {
          addError(error);
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MarketStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // PROCESS INCOMING TICK
  // ============================================================

  void _onTickReceived(
    TickReceived event,
    Emitter<MarketState> emit,
  ) {
    final tick = event.tick as Tick;

    emit(
      state.copyWith(
        currentPrice: tick.price,
      ),
    );
  }

  // ============================================================
  // DISCONNECT WEBSOCKET
  // ============================================================

  Future<void> _onDisconnectMarketStream(
    DisconnectMarketStream event,
    Emitter<MarketState> emit,
  ) async {
    try {
      await _tickSubscription?.cancel();

      _tickSubscription = null;

      await repository.disconnectWebSocket();

      emit(
        state.copyWith(
          status: MarketStatus.disconnected,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MarketStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // CLOSE BLOC
  // ============================================================

  @override
  Future<void> close() async {
    await _tickSubscription?.cancel();

    _tickSubscription = null;

    await repository.disconnectWebSocket();

    return super.close();
  }
}