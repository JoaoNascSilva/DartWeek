import 'package:delivery_app/app/modules/menu/menu_controller.dart';
import 'package:delivery_app/app/modules/menu/menu_page.dart';
import 'package:delivery_app/app/repositpories/menu_repository.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeController extends GetxController {
  Future<void> openMenu(String pizzaSize) async {
    Get.put(MenuRepository(Get.find()));
    Get.put(MenuController(Get.find()));
    print('Abrindo tela.');
    await showBarModalBottomSheet(
      context: Get.context,
      builder: (context) {
        return MenuPage(pizzaSize);
      },
    );
    Get.delete<MenuController>();
    Get.delete<MenuRepository>();
    print('Fechando tela.');
  }
}
