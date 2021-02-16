import 'package:delivery_app/app/models/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShoppingCardItem extends StatelessWidget {
  final MenuItemModel item;
  final numerFormat =
      NumberFormat.currency(name: 'R\$', locale: 'pt_BR', decimalDigits: 2);

  ShoppingCardItem(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.name,
            style: TextStyle(),
          ),
          Text(
            numerFormat.format(item.price),
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
