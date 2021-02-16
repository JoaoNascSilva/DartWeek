import 'package:delivery_app/app/modules/shoppingCard/shopping_card_controller.dart';
import 'package:delivery_app/app/modules/shoppingCard/widgets/shopping_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShoppingCardItems extends GetView<ShoppingCardController> {
  final numerFormat =
      NumberFormat.currency(name: 'R\$', locale: 'pt_BR', decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Pedidos',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 10),
        ...controller.flavorSelected
            .map((item) => ShoppingCardItem(item))
            .toList(),
        Divider(thickness: 2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(),
              ),
              Text(
                numerFormat.format(controller.totalPrice),
                style: TextStyle(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
