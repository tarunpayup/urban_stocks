import 'package:flutter/material.dart';
import '../../services/auth_services.dart';

enum ViewState{idle, loading, success, error}

class SignupViewModel extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility(){
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<bool> signupValue(String name, String email, String password) async{
    _state = ViewState.loading;
    notifyListeners();

    try{
      await _authServices.signup(name, email, password);
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
