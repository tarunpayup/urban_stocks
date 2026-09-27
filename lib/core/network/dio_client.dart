import 'package:dio/dio.dart';
import 'package:stock_market/core/constants/api_constants.dart';

class DioClient{
  late final Dio dio;

  DioClient(){
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(
          seconds: 10
        ),
        receiveTimeout: const Duration(
          seconds: 20
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