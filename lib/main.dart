import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/features/market/repository/market_repository.dart';
import 'package:stock_market/features/market/repository/market_repository_impl.dart';
import 'package:stock_market/features/market/data/datasource/market_api_datasource.dart';
import 'package:stock_market/features/market/data/datasource/market_websocket_datasource.dart';

import 'core/network/dio_client.dart';
import 'core/network/websocket_client.dart';


import 'features/market/presentation/bloc/market_bloc.dart';
import 'features/market/presentation/pages/market_page.dart';

void main() {

  // =========================================================
  // DIO CLIENT
  // =========================================================

  final dioClient = DioClient();

  // =========================================================
  // WEBSOCKET CLIENT
  // =========================================================

  final websocketClient = WebsocketClient();

  // =========================================================
  // API DATA SOURCE
  // =========================================================

  final apiDataSource = MarketApiDatasource(
    dio: dioClient.dio,
  );

  // =========================================================
  // WEBSOCKET DATA SOURCE
  // =========================================================

  final websocketDataSource =
      MarketWebsocketDatasource(
    client: websocketClient,
  );

  // =========================================================
  // REPOSITORY
  // =========================================================

  final MarketRepository repository =
      MarketRepositoryImpl(
    apiDatasource: apiDataSource,
    websocketDatasource: websocketDataSource,
  );

  // =========================================================
  // RUN APPLICATION
  // =========================================================

  runApp(
    MyApp(
      repository: repository,
    ),
  );
}

class MyApp extends StatelessWidget {

  final MarketRepository repository;

  const MyApp({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Market App',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),

      home: BlocProvider(
        create: (_) => MarketBloc(
          repository: repository,
        ),

        child: const MarketPage(),
      ),
    );
  }
}