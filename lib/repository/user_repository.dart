import 'package:stock_market/models/user_model.dart';
import 'package:stock_market/services/api_service.dart';

class UserRepository {
  ApiService apiService = ApiService();

  Future<List<UserModel>> getUsers() async{
    return await apiService.getUsers();
  }
}