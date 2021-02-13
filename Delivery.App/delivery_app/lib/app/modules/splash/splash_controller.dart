import 'package:delivery_app/app/models/user_logged.dart';
import 'package:delivery_app/app/modules/home/home_page.dart';
import 'package:delivery_app/app/modules/login/login_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final _userLogged = UserLogged.empty.obs;

  UserLogged get userLogged => _userLogged.value;

  @override
  void onInit() {
    super.onInit();
    ever<UserLogged>(_userLogged, _checkIsLogged);
    checkLogin();
  }

  Future<void> checkLogin() async {
    final sharedPrefences = await SharedPreferences.getInstance();
    sharedPrefences.clear();
    if (sharedPrefences.containsKey('user')) {
      //Direcionar para Home
      _userLogged(UserLogged.authenticate); //ScalladClass
    } else {
      //Direcionar para Login
      _userLogged(UserLogged.unauthenticate); //ScalladClass
    }
  }

  void _checkIsLogged(UserLogged callback) {
    switch (userLogged) {
      case UserLogged.authenticate:
        Get.offAllNamed(HomePage.ROUTE_PAGE);
        break;
      case UserLogged.unauthenticate:
        Get.offAllNamed(LoginPage.ROUTE_PAGE);
        break;
      case UserLogged.empty:
        break;
      default:
        break;
    }
  }
}
