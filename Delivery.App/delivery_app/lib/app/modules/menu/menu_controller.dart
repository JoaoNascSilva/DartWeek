import 'package:delivery_app/app/models/menu_item.dart';
import 'package:delivery_app/app/models/menu_model.dart';
import 'package:delivery_app/app/modules/shoppingCard/shopping_card_controller.dart';
import 'package:delivery_app/app/modules/shoppingCard/shopping_card_page.dart';
import 'package:delivery_app/app/repositories/menu_repository.dart';
import 'package:delivery_app/app/repositories/order_repository.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MenuController extends GetxController {
  final MenuRepository _repository;
  final _menu = <MenuModel>[].obs;

  final _flavorsSelected = <MenuItemModel>[].obs;

  List<MenuModel> get menu => _menu;
  List<MenuItemModel> get flavorsSelected => _flavorsSelected;
  double get totalValue =>
      _flavorsSelected.fold(0, (value, item) => value += item.price);

  MenuController(this._repository);

  @override
  void onInit() async {
    super.onInit();
    final menuData = await _repository.findAll();
    _menu.assignAll(menuData);
  }

  void addItem(MenuItemModel item) {
    if (_flavorsSelected.contains(item)) {
      _flavorsSelected.remove(item);
    } else {
      _flavorsSelected.add(item);
    }
  }

  Future<void> goToShoppingCard() async {
    Get.put(OrdersRepository(Get.find()));
    Get.put(ShoppingCardController(Get.find(), _flavorsSelected));
    await showBarModalBottomSheet(
      context: Get.context,
      isDismissible: false,
      builder: (_) {
        return ShoppingCardPage();
      },
    );
    Get.delete<OrdersRepository>();
    Get.delete<ShoppingCardController>();
  }
}
