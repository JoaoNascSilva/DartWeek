import 'package:delivery_app/app/components/pizza_delivery_button.dart';
import 'package:delivery_app/app/components/pizza_delivery_input.dart';
import 'package:delivery_app/app/modules/registrer/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  static const String ROUTE_PAGE = '/login';

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
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
                          controller: emailEditingController,
                          label: 'E-mail',
                          validator: (String value) {
                            if (value == null ||
                                value.isBlank ||
                                !value.isEmail) return 'E-mail invalido.';
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
                            obscureText: controller.obscureText,
                            validator: (String value) {
                              if (value.length < 6)
                                return 'Senha deve conter no minimo 6 caracteres.';
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        PizzaDeliveryButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              controller.login(
                                emailEditingController.text,
                                passwordEditingController.text,
                              );
                            }
                          },
                          width: Get.mediaQuery.size.width * 0.8,
                          height: 50,
                          buttomColor: Get.theme.primaryColor,
                          label: 'LogIn',
                          labelSize: 20,
                          labelColor: Colors.white,
                        ),
                        SizedBox(height: 20),
                        PizzaDeliveryButton(
                          onPressed: () => Get.toNamed(RegisterPage.ROUTE_PAGE),
                          buttomColor: Colors.orange[400],
                          height: 50,
                          label: 'Cadatre-se',
                          labelColor: Colors.white,
                          labelSize: 20,
                          width: Get.mediaQuery.size.width * 0.80,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
