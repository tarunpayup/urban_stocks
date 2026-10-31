import  'package:flutter/material.dart';
import 'package:stock_market/views/auth/login_screen.dart';


void main(){
  runApp(const UrbanStocksApp());
}

class UrbanStocksApp extends StatelessWidget{
  const UrbanStocksApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}