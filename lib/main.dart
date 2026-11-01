import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/auth/login_screen.dart';

void main() {
  runApp(
    const ProviderScope( // Riverpod requires this at the root
      child: UrbanStocksApp(),
    ),
  );
}

class UrbanStocksApp extends StatelessWidget {
  const UrbanStocksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Stocks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}