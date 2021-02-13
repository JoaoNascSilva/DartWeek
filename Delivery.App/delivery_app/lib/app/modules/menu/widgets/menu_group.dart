import 'package:delivery_app/app/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../menu_controller.dart';

class MenuGroup extends GetView<MenuController> {
  final MenuModel _menu;
  final formatter = NumberFormat('###0.00', 'pt_BR');

  MenuGroup(this._menu);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Text(
            _menu.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(thickness: 1),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _menu.items.length,
          itemBuilder: (_, index) {
            final item = _menu.items[index];
            return ListTile(
              title: Text(
                item.name,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                'R\$ ${formatter.format(item.price)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Obx(
                () {
                  final itemSelected =
                      controller.flavorsSelected.contains(item);
                  return IconButton(
                    icon: Icon(
                      itemSelected
                          ? FontAwesome.minus_square
                          : FontAwesome.plus_square,
                      size: 18,
                    ),
                    color: Get.theme.primaryColor,
                    onPressed: () => controller.addItem(item),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
