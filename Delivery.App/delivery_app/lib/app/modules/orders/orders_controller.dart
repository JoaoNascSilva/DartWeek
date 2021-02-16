import 'package:delivery_app/app/models/user_model.dart';
import 'package:delivery_app/app/repositories/order_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersController extends GetxController with StateMixin {
  final OrdersRepository _repository;
  UserModel _user;

  OrdersController(this._repository);

  @override
  void onInit() async {
    super.onInit();
    final sharedPreferences = await SharedPreferences.getInstance();
    _user = UserModel.fromJson(sharedPreferences.getString('user'));
    findOrders();
  }

  void findOrders() async {
    try {
      change([], status: RxStatus.loading());
      final orders = await _repository.findMyOrders(_user.id);
      change(orders, status: RxStatus.success());
    } catch (e) {
      change('Erro ao buscar pedidos', status: RxStatus.error());
    }
  }
}
