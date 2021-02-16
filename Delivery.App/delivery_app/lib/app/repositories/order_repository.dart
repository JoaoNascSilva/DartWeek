import 'package:delivery_app/app/Helpers/rest_client.dart';
import 'package:delivery_app/app/models/order_model.dart';
import 'package:delivery_app/app/view_models/checkout_inpout_model.dart';

class OrdersRepository {
  final RestClient _restClient;

  OrdersRepository(this._restClient);

  Future<List<OrderModel>> findMyOrders(int userId) async {
    final response = await _restClient.get(
      '/order/user/$userId',
      decoder: (response) {
        if (response is List)
          return response
              .map<OrderModel>((o) => OrderModel.fromMap(o))
              .toList();

        return null;
      },
    );

    if (response.hasError) {
      print(response.statusText);
      throw RestClientException('Erro ao buscar pedidos.');
    }

    return response.body;
  }

  Future<void> saveOrder(CheckoutInpoutModel model) async {
    switch (model.paymentType) {
      case 'Cartao de Credito':
        model.paymentType = 'credito';
        break;
      case 'Cartao de Debito':
        model.paymentType = 'debito';
        break;
      case 'Dinheiro':
        model.paymentType = 'dinheiro';
        break;
    }

    final response = await RestClient().post('/order/', model.toMap());

    if (response.hasError) {
      print(response.statusText);
      throw RestClientException('Erro ao registrar pedido');
    }
  }
}
