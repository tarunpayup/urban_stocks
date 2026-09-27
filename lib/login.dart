import 'package:flutter/material.dart';
//Stateful 
class Login extends StatefulWidget{
  const Login({super.key});
  @override
  State<Login> createState()=> _LoginState();
}
//State
class _LoginState extends State<Login>{
  int number = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("Click Me"),
        onPressed: (){
          number++;
          print("Floating action button is clicked by $number");
        },
      ),
      body: Center(
        child: Text("This text is under Center inside Scaffold body"),
      ),
    );
    }
}