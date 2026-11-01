import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market/provider/stock_provider.dart';
import '../../providers/stock_providers.dart';
import '../../core/widgets/stock_list_tile.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksAsync = ref.watch(stockListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Urban Stocks')),
      body: stocksAsync.when(
        data: (stocks) => ListView.separated(
          itemCount: stocks.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) => StockListTile(stock: stocks[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}