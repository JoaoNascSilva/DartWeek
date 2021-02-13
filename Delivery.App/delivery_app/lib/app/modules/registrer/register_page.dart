import 'package:delivery_app/app/components/pizza_delivery_button.dart';
import 'package:delivery_app/app/components/pizza_delivery_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  static const String ROUTE_PAGE = '/register';

  final formKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmedPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Get.mediaQuery.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      PizzaDeliveryInput(
                        //controller: emailEditingController,
                        label: 'Nome',
                        validator: (String value) {
                          if ((value.length < 3 || value.length >= 60) ||
                              value.isBlank)
                            return 'Campo [Nome] deve conter entre 3 e 60 caracteres.';
                          return null;
                        },
                        suffixIconsOnPressed: () {},
                      ),
                      PizzaDeliveryInput(
                        controller: nameEditingController,
                        label: 'E-mail',
                        validator: (String value) {
                          if (value == null || value.isBlank || !value.isEmail)
                            return 'E-mail invalido.';
                          return null;
                        },
                        suffixIconsOnPressed: () {},
                      ),
                      Obx(
                        () => PizzaDeliveryInput(
                          controller: passwordEditingController,
                          label: 'Senha',
                          suffixIcon: Icon(FontAwesome.key),
                          suffixIconsOnPressed: controller.showHidePassword,
                          obscureText: controller.obscureTextPassword,
                          validator: (String value) {
                            if (value.length < 6)
                              return 'Senha deve conter no minimo 6 caracteres.';
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => PizzaDeliveryInput(
                          controller: confirmedPasswordEditingController,
                          label: 'Confirmar Senha',
                          suffixIcon: Icon(FontAwesome.key),
                          suffixIconsOnPressed:
                              controller.showHideConfirmePassword,
                          obscureText: controller.obscureTextConfirmPassword,
                          validator: (String value) {
                            if (value != passwordEditingController.text)
                              return 'Senha deve conter no minimo 6 caracteres.';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      PizzaDeliveryButton(
                        width: Get.mediaQuery.size.width * 0.8,
                        height: 50,
                        buttomColor: Get.theme.primaryColor,
                        label: 'Salvar ',
                        labelSize: 20,
                        labelColor: Colors.white,
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            final name = nameEditingController.text;
                            final email = emailEditingController.text;
                            final password = passwordEditingController.text;
                            controller.registerUser(name, email, password);
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      PizzaDeliveryButton(
                        buttomColor: Colors.orange[400],
                        height: 50,
                        label: 'Voltar',
                        labelColor: Colors.white,
                        labelSize: 20,
                        width: Get.mediaQuery.size.width * 0.80,
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
