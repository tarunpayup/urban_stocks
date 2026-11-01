import 'package:flutter/material.dart';
import '../../models/stock_model.dart';

class StockListTile extends StatefulWidget {
  final StockModel stock;

  const StockListTile({super.key, required this.stock});

  @override
  State<StockListTile> createState() => _StockListTileState();
}

class _StockListTileState extends State<StockListTile> {
  Color _flashColor = Colors.transparent;
  double? _previousPrice;

  @override
  void didUpdateWidget(covariant StockListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _previousPrice = oldWidget.stock.price;

    if (widget.stock.price != _previousPrice) {
      final isUp = widget.stock.price > _previousPrice!;
      setState(() {
        _flashColor = (isUp ? Colors.green : Colors.red).withOpacity(0.15);
      });

      // fade the flash back out
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) setState(() => _flashColor = Colors.transparent);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final stock = widget.stock;
    final color = stock.isUp ? Colors.green : Colors.red;
    final arrow = stock.isUp ? Icons.arrow_upward : Icons.arrow_downward;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      color: _flashColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey.shade100,
          child: Text(
            stock.symbol.substring(0, 2),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(stock.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(stock.companyName),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${stock.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(arrow, size: 14, color: color),
                const SizedBox(width: 2),
                Text(
                  '${stock.change.toStringAsFixed(2)} (${stock.changePercent.toStringAsFixed(2)}%)',
                  style: TextStyle(color: color, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}