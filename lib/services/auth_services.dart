class AuthServices {
  Future<bool> login(String email, String password) async{
    await Future.delayed(const Duration(seconds: 10));
    if(email == "myaccount@gmail.com" && password == "123456"){
      return true;
    }
    throw Exception("Invalid Email and Password");
  }
}