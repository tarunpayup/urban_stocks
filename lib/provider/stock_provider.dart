import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market/models/stock_model.dart';
import 'package:stock_market/services/stock_service.dart';

final stockServiceProvider = Provider<StockService>((ref) => StockService());

final stockListProvider = StreamProvider<List<StockModel>>((ref){
  final service = ref.watch(stockServiceProvider);
  return service.watchStocks();
});