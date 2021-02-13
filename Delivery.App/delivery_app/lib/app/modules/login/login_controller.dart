import 'package:delivery_app/app/Helpers/loader_mixin.dart';
import 'package:delivery_app/app/Helpers/messages_mixin.dart';
import 'package:delivery_app/app/Helpers/rest_client.dart';
import 'package:delivery_app/app/modules/home/home_page.dart';
import 'package:delivery_app/app/repositpories/user_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  final UserRepository _repository;
  final _obscureText = true.obs;
  final loading = false.obs;
  final message = Rx<MessageModel>();

  LoginController(this._repository);

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  get obscureText => _obscureText.value;

  void showHidePassword() => _obscureText.toggle();

  void login(String email, String password) async {
    try {
      loading(true);
      message(null);

      final user = await _repository.login(email, password);
      final sharedPreference = await SharedPreferences.getInstance();
      await sharedPreference.setString('user', user.toJson());

      loading(false);

      Get.offAndToNamed(HomePage.ROUTE_PAGE);
    } on RestClientException catch (e) {
      print(e);
      loading(false);
      message(MessageModel('Erro', e.message, MessageType.error));
    } catch (e) {
      print(e);
      loading(false);
      message(MessageModel(
          'Erro', 'Erro ao autenticar o usuario', MessageType.error));
    }
  }
}
