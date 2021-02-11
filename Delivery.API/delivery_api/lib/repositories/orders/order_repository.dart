import 'package:delivery_api/application/database/IDatabaseConnection.dart';
import 'package:delivery_api/application/entities/menu_item.dart';
import 'package:delivery_api/application/entities/order.dart';
import 'package:delivery_api/application/entities/order_item.dart';
import 'package:delivery_api/application/exceptions/databaseErrorExceptions.dart';
import 'package:delivery_api/modules/orders/view_models/save_order_input_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import 'i_order_repository.dart';

@LazySingleton(as: IOrderRepository)
class OrderRepository implements IOrderRepository {
  final IDatabaseConnection _connection;

  OrderRepository(this._connection);

  @override
  Future<void> saveOrder(SaveOrderInputModel saveOrder) async {
    final connection = await _connection.openConnection();

    try {
      await connection.transaction((_) async {
        final resultOrder = await connection.query('''
          INSERT INTO pedido(
            id_usuario,
            forma_pagamento,
            endereco_entrega
          ) VALUES (
            ?,
            ?,
            ?
          );
        ''', [
          saveOrder.userId,
          saveOrder.paymentType,
          saveOrder.address,
        ]);

        final orderId = resultOrder.insertId;

        await connection.queryMulti(''' 
          INSERT INTO pedido_item (
            id_pedido,
            id_cardapio_grupo_item
          ) VALUES(?, ?);
        ''', saveOrder.itemsId.map((item) => [orderId, item]));
      });
    } on MySqlException catch (e) {
      print(e);
      throw DataBaseException(message: 'Erro ao inserir ordem.');
    } finally {
      await connection?.close();
    }
  }

  @override
  Future<List<Order>> findMyOrders(int userId) async {
    final connection = await _connection.openConnection();
    final orders = <Order>[];

    try {
      final ordersResult = await connection.query('''
        SELECT 
          id_pedido,
          id_usuario,
          forma_pagamento,
          endereco_entrega
        FROM pedido
        WHERE 
          id_usuario = ?;
      ''', [userId]);

      if (ordersResult.isNotEmpty) {
        for (var orderResult in ordersResult) {
          final orderData = orderResult.fields;
          final orderItemsReult = await connection.query('''
            SELECT 
	            pedidoitem.id_pedido_item,
	            pedidoitem.id_cardapio_grupo_item,
	            pedidoitem.id_pedido,
              cardapio.nome,
              cardapio.valor
            FROM pedido_item pedidoitem
            INNER JOIN cardapio_grupo_item cardapio ON pedidoitem.id_cardapio_grupo_item = cardapio.id_cardapio_grupo_item
            WHERE pedidoitem.id_pedido = ?
          ''', [orderData['id_pedido']]);

          final items = orderItemsReult.map<OrderItem>((item) {
            final itemFields = item.fields;
            return OrderItem(
              id: itemFields['id_pedido_item'],
              item: MenuItem(
                id: itemFields['id_cardapio_grupo_item'] as int,
                name: itemFields['nome'] as String,
                price: itemFields['valor'] as double,
              ),
            );
          }).toList();

          final order = Order(
            id: orderData['id_pedido'] as int,
            address: (orderData['endereco_entrega'] as Blob).toString(),
            paymentType: orderData['forma_pagamento'] as String,
            items: items,
          );

          orders.add(order);
        }
      }

      return orders;
    } on MySqlException catch (e) {
      print(e);
      throw DataBaseException(message: 'Erro ao buscar pedidos.');
    }
  }
}
