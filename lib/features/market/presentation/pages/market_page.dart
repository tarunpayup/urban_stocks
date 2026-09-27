import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/market_bloc.dart';
import '../bloc/market_event.dart';
import '../bloc/market_state.dart';

import '../widgets/candlestick_chart.dart';
import '../widgets/market_header.dart';
import '../widgets/timeframe_selector.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({
    super.key,
  });

  @override
  State<MarketPage> createState() =>
      _MarketPageState();
}

class _MarketPageState
    extends State<MarketPage> {

  String selectedTimeframe = '1m';

  @override
  void initState() {
    super.initState();

    final bloc =
        context.read<MarketBloc>();

    // -----------------------------------------------
    // LOAD HISTORICAL DATA
    // -----------------------------------------------

    bloc.add(
      const LoadMarketData(),
    );

    // -----------------------------------------------
    // CONNECT LIVE MARKET STREAM
    // -----------------------------------------------

    bloc.add(
      const ConnectMarketStream(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Market',
        ),
        centerTitle: false,
      ),

      body: BlocBuilder<
          MarketBloc,
          MarketState>(
        builder: (
          context,
          state,
        ) {

          // -------------------------------------------
          // ERROR
          // -------------------------------------------

          if (state.status ==
                  MarketStatus.error &&
              state.candles.isEmpty) {

            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [

                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    const Text(
                      'Unable to load market data',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      state.errorMessage ??
                          'Unknown error',
                      textAlign:
                          TextAlign.center,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(
                      onPressed: () {

                        context
                            .read<MarketBloc>()
                            .add(
                              const LoadMarketData(),
                            );

                      },
                      child: const Text(
                        'Retry',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // -------------------------------------------
          // MAIN MARKET SCREEN
          // -------------------------------------------

          return SafeArea(
            child: Column(
              children: [

                // -------------------------------------
                // HEADER
                // -------------------------------------

                MarketHeader(
                  currentPrice:
                      state.currentPrice,
                  status:
                      state.status.name,
                ),

                const SizedBox(
                  height: 8,
                ),

                // -------------------------------------
                // TIMEFRAME
                // -------------------------------------

                TimeframeSelector(
                  selectedTimeframe:
                      selectedTimeframe,

                  onChanged: (
                    timeframe,
                  ) {

                    setState(() {
                      selectedTimeframe =
                          timeframe;
                    });

                  },
                ),

                const SizedBox(
                  height: 10,
                ),

                // -------------------------------------
                // CHART
                // -------------------------------------

                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: CandlestickChart(
                      candles:
                          state.candles,
                      minY: state.minY,
                      maxY: state.maxY,
                      minX: state.minX,
                      maxX: state.maxX,
                    ),
                  ),
                ),

                // -------------------------------------
                // DATA INFORMATION
                // -------------------------------------

                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    16,
                    4,
                    16,
                    12,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [

                      Text(
                        '${state.candles.length} candles',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        'Timeframe: '
                        '$selectedTimeframe',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}