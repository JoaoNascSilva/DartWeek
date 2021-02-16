import 'package:delivery_app/app/components/pizza_delivery_button.dart';
import 'package:delivery_app/app/modules/shoppingCard/widgets/shopping_card_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shopping_card_controller.dart';

class ShoppingCardPage extends GetView<ShoppingCardController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Sacola',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Get.back(),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (_, constructor) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constructor.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Nome',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          controller.userName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Divider(thickness: 2),
                      ShoppingCardItems(),
                      Divider(thickness: 2),
                      ListTile(
                        title: Text('Endereco de Entrega'),
                        subtitle: Obx(() => Text(controller.address)),
                        trailing: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Get.theme.accentColor.withAlpha(128),
                            ),
                          ),
                          child: Text(
                            'Alterar',
                            style: TextStyle(
                              color: Get.theme.primaryColor.withOpacity(1.0),
                            ),
                          ),
                          onPressed: () => controller.changeAddress(),
                        ),
                      ),
                      Divider(thickness: 2),
                      ListTile(
                        title: Text(
                          'Forma de Pagamento',
                          style: TextStyle(),
                        ),
                        subtitle: Obx(() => Text(controller.paymentType)),
                        trailing: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Get.theme.accentColor.withAlpha(128),
                            ),
                          ),
                          child: Text(
                            'Alterar',
                            style: TextStyle(
                              color: Get.theme.primaryColor.withOpacity(1.0),
                            ),
                          ),
                          onPressed: () => controller.changePaymentType(),
                        ),
                      ),
                      Divider(thickness: 2),
                      Expanded(
                        child: SizedBox.shrink(),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: PizzaDeliveryButton(
                            label: 'Finalizar Pedido',
                            width: Get.mediaQuery.size.width * .9,
                            height: 40,
                            buttomColor: Get.theme.primaryColor,
                            labelSize: 18,
                            labelColor: Colors.white,
                            onPressed: () => controller.checkOut(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
