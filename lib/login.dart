import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stock_market/dashboard.dart';

class Login extends StatefulWidget{
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(){
    String userName = usernameController.text;
    String password = passwordController.text;

    if(userName == "Admin" && password == "Abc@123"){
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context)=> Dashboard()));
    }else{
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text("Invalid user id or password"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Ok"))
            ],
          );
        }
        );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Username
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            //Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder()
              ),
            ),      
                  SizedBox(height: 20,),
            //Button
            ElevatedButton(onPressed: login, child: Text("Sign In"))
          ],
        ),
        ),
    );
  }
}