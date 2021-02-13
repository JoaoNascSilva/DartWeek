import 'package:delivery_app/app/modules/registrer/register_controller.dart';
import 'package:delivery_app/app/repositpories/user_repository.dart';
import 'package:get/get.dart';

class RegisterBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(Get.find()));
    Get.put(RegisterController(Get.find()));
  }
}
