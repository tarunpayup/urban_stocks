class StockModel {
  final String symbol;
  final String companyName;
  final double price;
  final double change;
  final double changePercent;

  const StockModel({
    required this.symbol,
    required this.companyName,
    required this.price,
    required this.change,
    required this.changePercent
  });

  bool get isUp => change >= 0;

  StockModel copyWith({double? price, double? change, double? changePercent}){
    return StockModel(symbol: symbol, 
    companyName: companyName, 
    price: price ?? this.price, 
    change: change ?? this.change, 
    changePercent: changePercent??this.changePercent);
  }
}