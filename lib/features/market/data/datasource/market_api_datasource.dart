import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/candle_models.dart';

class MarketApiDatasource {
  final Dio dio;

  MarketApiDatasource({required this.dio});

  Future<List<CandleModels>> getCandles() async{
    final response = await dio.get(
      '/api/candles'
    );

    final List<dynamic> data = response.data;

    return data.map(
      (json)=> CandleModels.fromJson(
        json
      )
    ).toList();
  }
}