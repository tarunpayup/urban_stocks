import 'dart:convert';

import 'package:stock_market/models/user_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  Future<List<UserModel>> getUsers() async{

    try{
    final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users")
    );
    if(response.statusCode == 200){
      List<dynamic> jsonData = jsonDecode(response.body);
      List<UserModel> users = jsonData.map((item){
          return UserModel.fromJson(item);
      }).toList();

      return users;
    }else{
      throw Exception('Failed to load users: ${response.statusCode}');
    }
    }catch(e){
      rethrow;
    }
  }
}