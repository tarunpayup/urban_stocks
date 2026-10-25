class AuthServices {
  Future<bool> login(String email, String password) async{
    await Future.delayed(const Duration(seconds: 2));
    if(email == "myaccount@gmail.com" && password == "123456"){
      return true;
    }
    throw Exception("Invalid Email and Password");
  }

  Future<bool> signup(String name, String email, String password) async{
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}