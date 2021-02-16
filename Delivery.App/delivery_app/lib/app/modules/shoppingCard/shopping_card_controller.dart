import 'package:delivery_app/app/Helpers/loader_mixin.dart';
import 'package:delivery_app/app/Helpers/messages_mixin.dart';
import 'package:delivery_app/app/models/menu_item.dart';
import 'package:delivery_app/app/models/user_model.dart';
import 'package:delivery_app/app/repositories/order_repository.dart';
import 'package:delivery_app/app/view_models/checkout_inpout_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCardController extends GetxController
    with MessagesMixin, LoaderMixin {
  final OrdersRepository _orderRepository;

  final RxList<MenuItemModel> flavorSelected;
  final _user = Rx<UserModel>();
  final _address = ''.obs;
  final _paymentType = ''.obs;
  final addressEditingController = TextEditingController();
  final _message = Rx<MessageModel>();
  final _loading = false.obs;

  String get userName => _user.value?.name ?? '';
  double get totalPrice =>
      flavorSelected.fold(0, (total, item) => total + item.price);

  String get address => _address.value;
  String get paymentType => _paymentType.value;

  ShoppingCardController(this._orderRepository, this.flavorSelected);

  @override
  Future<void> onInit() async {
    super.onInit();
    messageListener(_message);
    loaderListener(_loading);
    final sharedPreferences = await SharedPreferences.getInstance();
    _user(UserModel.fromJson(sharedPreferences.getString('user')));
  }

  void checkOut() async {
    if (address.isBlank)
      _message(
        MessageModel(
            'Erro', 'Endereco de entrega nao informado.', MessageType.error),
      );
    else if (paymentType.isBlank)
      _message(
        MessageModel(
            'Erro', 'Forma de Pagamento nao informada.', MessageType.error),
      );
    else {
      _loading(true);

      //Chama o Repositorio
      await _orderRepository.saveOrder(
        CheckoutInpoutModel(
          userId: _user.value.id,
          address: address,
          paymentType: paymentType,
          itemsId: flavorSelected.map<int>((f) => f.id).toList(),
        ),
      );

      try {
        _loading(false);
        _message(MessageModel(
            'Sucesso', 'Pedido realizado com sucesso,', MessageType.success));
        await 1.seconds.delay();
        Get.close(3);
      } on Exception catch (e) {
        print(e);
        _loading(false);
        _message(MessageModel(
            'Erro', 'Erro ao registrar o pedido.', MessageType.success));
      }
    }
  }

  Future<void> changePaymentType() async {
    await Get.defaultDialog(
      title: 'Forma de Pagamento',
      content: Container(
        height: 150,
        child: RadioButtonGroup(
          labels: [
            'Dinheiro',
            'Cartao de Credito',
            'Cartao de Debito',
          ],
          onSelected: (String value) => _paymentType(value),
        ),
      ),
      cancel: RaisedButton(
        color: Get.theme.primaryColor,
        textColor: Colors.white,
        child: Text('Cancelar'),
        onPressed: () => Get.back(),
      ),
      confirm: RaisedButton(
        color: Get.theme.primaryColor,
        textColor: Colors.white,
        child: Text('Confirmar'),
        onPressed: () => Get.back(),
      ),
    );
  }

  Future<void> changeAddress() async {
    await Get.defaultDialog(
      title: 'Endereco de Entrega',
      content: TextField(
        controller: addressEditingController,
      ),
      cancel: RaisedButton(
        color: Get.theme.primaryColor,
        textColor: Colors.white,
        child: Text('Cancelar'),
        onPressed: () => Get.back(),
      ),
      confirm: RaisedButton(
        color: Get.theme.primaryColor,
        textColor: Colors.white,
        child: Text('Confirmar'),
        onPressed: () {
          _address(addressEditingController.text);
          addressEditingController.clear();
          Get.back();
        },
      ),
    );
  }
}
