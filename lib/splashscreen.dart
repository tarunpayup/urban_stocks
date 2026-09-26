import 'dart:async';

import 'package:flutter/material.dart';

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
      print("3 seconds done");
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