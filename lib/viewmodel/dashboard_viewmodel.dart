import 'package:stock_market/models/user_model.dart';
import 'package:stock_market/repository/user_repository.dart';

class DashboardViewModel{
  //To setup the viewmodel initialization
  UserRepository userRepository = UserRepository(); //Repository
  List<UserModel> users = [];
  bool isLoading = false;
  String errorMessage = '';

  //Calling the api -> Repository -> API Service -> Data return to API Service -> Model -> Repository -> Viewmodel

  Future<void> loadUsers() async{
    try{
      isLoading = true;
      users = await userRepository.getUsers();
      isLoading = false;
    }catch(e){
      isLoading = false;
      errorMessage = e.toString();
    }
  }

}