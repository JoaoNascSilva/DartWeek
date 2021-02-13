import 'package:delivery_app/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBidings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
