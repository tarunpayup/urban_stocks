import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/features/market/repository/market_repository.dart';

import '../../domain/entities/candle.dart';
import '../../domain/entities/tick.dart';


import 'market_event.dart';
import 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final MarketRepository repository;

  StreamSubscription<Tick>? _tickSubscription;

  MarketBloc({
    required this.repository,
  }) : super(const MarketState()) {
    // ==========================================================
    // EVENTS
    // ==========================================================

    // Load historical candle data using Dio
    on<LoadMarketData>(
      _onLoadMarketData,
    );

    // Connect to WebSocket
    on<ConnectMarketStream>(
      _onConnectMarketStream,
    );

    // Handle incoming WebSocket tick
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
      // Tell UI that historical data is loading
      emit(
        state.copyWith(
          status: MarketStatus.loading,
          errorMessage: null,
        ),
      );

      // Call repository
      //
      // Repository
      //     ↓
      // API Data Source
      //     ↓
      // Dio
      //     ↓
      // Go REST API
      //     ↓
      // historical.json
      //
      final candles =
          await repository.getHistoricalCandles();

      // Compute fixed axis bounds from the full candle set
      // up front so the chart stays constant while candles
      // are revealed one by one below.
      final minY = candles
          .map((c) => c.low)
          .reduce((a, b) => a < b ? a : b);

      final maxY = candles
          .map((c) => c.high)
          .reduce((a, b) => a > b ? a : b);

      // Add candles one by one so the chart builds up
      // progressively instead of rendering all at once.
      final revealedCandles = <Candle>[];

      for (final candle in candles) {
        revealedCandles.add(candle);

        emit(
          state.copyWith(
            status: MarketStatus.loaded,
            candles: List.of(revealedCandles),
            errorMessage: null,
            minY: minY,
            maxY: maxY,
            minX: candles.first.time,
            maxX: candles.last.time,
          ),
        );

        await Future.delayed(
          const Duration(milliseconds: 500),
        );
      }
    } catch (e) {
      // Something went wrong while loading
      // historical data.
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
      // Tell UI that WebSocket is connecting
      emit(
        state.copyWith(
          status: MarketStatus.connecting,
          errorMessage: null,
        ),
      );

      // Connect to WebSocket
      //
      // BLoC
      //   ↓
      // Repository
      //   ↓
      // WebSocket Data Source
      //   ↓
      // WebSocket Client
      //   ↓
      // Go WebSocket Server
      //
      await repository.connectWebSocket();

      // WebSocket successfully connected
      emit(
        state.copyWith(
          status: MarketStatus.connected,
          errorMessage: null,
        ),
      );

      // If another subscription already exists,
      // cancel it before creating a new one.
      await _tickSubscription?.cancel();

      // Start listening to live ticks
      _tickSubscription =
          repository.getLiveTick().listen(
        (tick) {
          // Whenever a new tick arrives,
          // convert it into a BLoC event.
          add(
            TickReceived(tick),
          );
        },
        onError: (error) {
          addError(error);
        },
      );
    } catch (e) {
      // WebSocket connection failed
      emit(
        state.copyWith(
          status: MarketStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // RECEIVE LIVE TICK
  // ============================================================

  void _onTickReceived(
    TickReceived event,
    Emitter<MarketState> emit,
  ) {
    // Convert event data into Tick
    final tick = event.tick as Tick;

    // For now, we are only updating the
    // current market price.
    //
    // Example:
    //
    // WebSocket sends:
    //
    // {
    //   "symbol": "AAPL",
    //   "price": 243.25,
    //   "volume": 110
    // }
    //
    // Then:
    //
    // currentPrice = 243.25
    //
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
      // Stop listening to WebSocket
      await _tickSubscription?.cancel();

      _tickSubscription = null;

      // Disconnect actual WebSocket
      await repository.disconnectWebSocket();

      // Update UI state
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
    // Cancel WebSocket stream subscription
    await _tickSubscription?.cancel();

    _tickSubscription = null;

    // Close WebSocket connection
    await repository.disconnectWebSocket();

    // Finally close BLoC
    return super.close();
  }
}