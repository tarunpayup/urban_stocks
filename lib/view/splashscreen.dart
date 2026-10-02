import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_market/view/login.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState(); //State declaration
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState(){
    super.initState();
    Timer( const Duration(seconds: 3),(){
     Navigator.push(
      context, 
      MaterialPageRoute(builder: (context)=>  Login()));
    }
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 42, 9),
      body: Center(
        child: Text("My Flutter App"),
      ),
    );
  }
}