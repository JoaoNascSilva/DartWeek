import 'package:delivery_app/app/config/ui_config.dart';
import 'package:delivery_app/app/modules/menu/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MenuBuyButton extends GetView<MenuController> {
  final formatter = NumberFormat('###0.00', 'pt_BR');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Row(
        children: [
          SizedBox(
            width: Get.mediaQuery.size.width * 0.50,
            child: Obx(
              () => Text(
                'Total R\$ ${formatter.format(controller.totalValue)}',
                style: TextStyle(
                  color: controller.flavorsSelected.isEmpty
                      ? Colors.black
                      : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    UIConfig.isEnableDisableColorButtom(
                      controller.flavorsSelected.isEmpty,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Fechar Pedido',
                    style: UIConfig.isEnableDisableColorText(
                      controller.flavorsSelected.isEmpty,
                    ),
                  ),
                ),
                onPressed: () {
                  if (controller.flavorsSelected.length > 0)
                    controller.goToShoppingCard();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
