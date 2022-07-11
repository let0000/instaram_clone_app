import 'package:get/get.dart';
import 'package:instaram_clone/src/models/instagram_user.dart';
import 'package:instaram_clone/src/repository/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<IUser> user = IUser().obs;

  Future<IUser?> loginUser(String uid) async {
    //DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    print(userData);
    return userData;
  }

  void signup(IUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if(result) {
      user(signupUser);
    }
  }
}