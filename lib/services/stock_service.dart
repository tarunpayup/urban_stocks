import 'dart:math';

import 'package:stock_market/models/stock_model.dart';

class StockService {
  final _random = Random();

  final List<StockModel> _initialStock = [
    const StockModel(symbol: "RELI", companyName: "Reliance Industries", price: 2850.30, change: 0, changePercent: 0),
    const StockModel(symbol: "TCS", companyName: "Tata Consultancy Services", price: 4190.76, change: 0, changePercent: 0),
    const StockModel(symbol: "INFY", companyName: "Infosys Limited", price: 1768.32, change: 0, changePercent: 0),
    const StockModel(symbol: "HDFC", companyName: "HDFC Bank", price: 1020.44, change: 0, changePercent: 0),
    const StockModel(symbol: "ITC", companyName: "ITC Limited", price: 899.12, change: 0, changePercent: 0)
  ];
}