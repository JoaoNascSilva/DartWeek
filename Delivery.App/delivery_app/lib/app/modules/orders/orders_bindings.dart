import 'package:delivery_app/app/modules/orders/orders_controller.dart';
import 'package:delivery_app/app/repositories/order_repository.dart';
import 'package:get/get.dart';

class OrdersBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(OrdersRepository(Get.find()));
    Get.put(OrdersController(Get.find()));
  }
}
