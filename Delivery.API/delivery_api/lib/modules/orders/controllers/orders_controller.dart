import 'dart:async';
import 'dart:convert';
import 'package:delivery_api/modules/orders/controllers/mapper/save_order_input_model_mapper.dart';
import 'package:delivery_api/services/orders/i_orders_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'orders_controller.g.dart';

@injectable
class OrdersController {
  final IOrdersService _service;

  OrdersController(this._service);

  @Route.post('/')
  Future<Response> saveOrder(Request request) async {
    try {
      final inputModel =
          SaveOrderInputModelMapper(await request.readAsString()).mapper();
      await _service.saveOrder(inputModel);
      return Response.ok('');
    } catch (e) {
      print(e);
      return Response.internalServerError(
          body: jsonEncode({'message': 'Erro ao salvar a ordem.'}));
    }
  }

  @Route.get('/user/<userId>')
  Future<Response> find(Request request, String userId) async {
    final orders = await _service.findMyOrders(int.parse(userId));
    final orderResponse = orders.map((o) => o.toMap()).toList();

    return Response.ok(jsonEncode(orderResponse));
  }

  Router get router => _$OrdersControllerRouter(this);
}
