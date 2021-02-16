import 'package:delivery_app/app/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPanel extends StatelessWidget {
  final OrderModel order;
  final formatNumberPrice = NumberFormat.currency(
    name: 'R\$',
    locale: 'pt_BR',
    decimalDigits: 2,
  );

  HistoryPanel(this.order, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Pedido ${order.id}'),
      children: [
        Divider(color: Colors.yellow[500]),
        ...order.items.map(
          (o) {
            return Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(o.item.name),
                  Text('${formatNumberPrice.format(o.item.price)}')
                ],
              ),
            );
          },
        ).toList(),
        Divider(color: Colors.yellow[500]),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Text(
                'Total ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                formatNumberPrice.format(_calculateTotalOrder()),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _calculateTotalOrder() => order.items.fold(
        0,
        (total, o) => total += o.item.price,
      );
}
