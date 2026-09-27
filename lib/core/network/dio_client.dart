import 'package:dio/dio.dart';
import 'package:stock_market/core/constants/api_constants.dart';

class DioClient{
  late final Dio dio;

  DioClient(){
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        // Render free tier can take ~30s to wake from sleep
        connectTimeout: const Duration(
          seconds: 45
        ),
        receiveTimeout: const Duration(
          seconds: 45
        ),
        headers: {
          'Content-Type':'application/json'
        }
      )
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true
      )
    );
  }
}