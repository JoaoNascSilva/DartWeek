import 'package:delivery_app/app/Helpers/loader_mixin.dart';
import 'package:delivery_app/app/Helpers/messages_mixin.dart';
import 'package:delivery_app/app/Helpers/rest_client.dart';
import 'package:delivery_app/app/repositpories/user_repository.dart';
import 'package:delivery_app/app/view_models/register_user_input_model.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController
    with LoaderMixin, MessagesMixin {
  final UserRepository _repository;

  final _obscureTextPassword = true.obs;
  final _obscureTextConfirmPassword = true.obs;
  final _loading = false.obs;
  final _message = Rx<MessageModel>();

  RegisterController(this._repository);

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  bool get obscureTextPassword => _obscureTextPassword.value;
  bool get obscureTextConfirmPassword => _obscureTextConfirmPassword.value;

  void showHidePassword() => _obscureTextPassword.toggle();
  void showHideConfirmePassword() => _obscureTextConfirmPassword.toggle();

  void registerUser(String name, email, String password) async {
    final inputModel = RegisterUserInputModel(
      name: name,
      email: email,
      password: password,
    );
    try {
      _loading(true);
      _message(null);
      _repository.saveUser(inputModel);
      _loading(false);
      _message(MessageModel(
          'Sucesso', 'Usuario cadastrado com sucesso.', MessageType.success));
      await 1.seconds.delay();
      Get.close(2);
    } on RestClientException catch (e) {
      _loading(false);
      _message(MessageModel('Erro', e.message, MessageType.error));
    } catch (e) {
      print(e);
      _loading(false);
      _message(MessageModel(
          'Erro', 'Erro ao registrar Usuario.', MessageType.error));
    }
  }
}
