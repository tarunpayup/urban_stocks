import "package:flutter/material.dart";
import '../../services/auth_services.dart';

enum ViewState { idle, loading, success, error }

class LoginViewmodel extends ChangeNotifier {

  final AuthServices _authServices = AuthServices();

  ViewState _state = ViewState.idle;
  ViewState get state => _state; //Getters and Setters

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _obsurePassword = true;
  bool get obscurePassword => _obsurePassword;

  void togglePasswordVisibility(){
    _obsurePassword = !_obsurePassword;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async{
    _state = ViewState.loading;
    notifyListeners();

    try{
      await _authServices.login(email, password);
      _state = ViewState.success;
      notifyListeners();
      return true;
    }catch(e){
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = ViewState.error;
      notifyListeners();
      return false;
    }
  }



}