import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../domain/entities/candle.dart';

class CandlestickChart extends StatelessWidget {
  final List<Candle> candles;

  // Fixed axis bounds so the chart doesn't rescale while
  // candles are revealed one by one.
  final double? minY;
  final double? maxY;
  final DateTime? minX;
  final DateTime? maxX;

  const CandlestickChart({
    super.key,
    required this.candles,
    this.minY,
    this.maxY,
    this.minX,
    this.maxX,
  });

  @override
  Widget build(BuildContext context) {
    if (candles.isEmpty) {
      return const Center(
        child: Text(
          'No candle data available',
        ),
      );
    }

    return SfCartesianChart(
      margin: const EdgeInsets.fromLTRB(
        10,
        10,
        10,
        5,
      ),

      // --------------------------------------------------
      // X AXIS
      // --------------------------------------------------

      primaryXAxis: DateTimeAxis(
        majorGridLines: const MajorGridLines(
          width: 0,
        ),
        axisLine: const AxisLine(
          width: 0,
        ),
        dateFormat: DateFormat.Hm(),
        minimum: minX,
        maximum: maxX,
      ),

      // --------------------------------------------------
      // Y AXIS
      // --------------------------------------------------

      primaryYAxis: NumericAxis(
        opposedPosition: true,
        majorGridLines: const MajorGridLines(
          width: 0.5,
        ),
        axisLine: const AxisLine(
          width: 0,
        ),
        rangePadding: ChartRangePadding.none,
        minimum: minY,
        maximum: maxY,
        numberFormat: NumberFormat.currency(
          symbol: '\$',
          decimalDigits: 2,
        ),
      ),

      // --------------------------------------------------
      // TOOLTIP
      // --------------------------------------------------

      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: '',
        canShowMarker: false,
      ),

      // --------------------------------------------------
      // TRACKBALL
      // --------------------------------------------------

      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipDisplayMode:
            TrackballDisplayMode.groupAllPoints,
      ),

      // --------------------------------------------------
      // ZOOM / PAN
      // --------------------------------------------------

      zoomPanBehavior: ZoomPanBehavior(
        enablePinching: true,
        enablePanning: true,
        enableMouseWheelZooming: true,
        zoomMode: ZoomMode.x,
      ),

      // --------------------------------------------------
      // CANDLESTICK SERIES
      // --------------------------------------------------

      series: <CartesianSeries<Candle, DateTime>>[
        CandleSeries<Candle, DateTime>(
          dataSource: candles,

          xValueMapper: (
            Candle candle,
            int index,
          ) {
            return candle.time;
          },

          openValueMapper: (
            Candle candle,
            int index,
          ) {
            return candle.open;
          },

          highValueMapper: (
            Candle candle,
            int index,
          ) {
            return candle.high;
          },

          lowValueMapper: (
            Candle candle,
            int index,
          ) {
            return candle.low;
          },

          closeValueMapper: (
            Candle candle,
            int index,
          ) {
            return candle.close;
          },

          // Candle appearance
          width: 0.7,
          spacing: 0.2,

          enableSolidCandles: true,

          // Price increased
          bullColor: Colors.green,

          // Price decreased
          bearColor: Colors.red,
        ),
      ],
    );
  }
}