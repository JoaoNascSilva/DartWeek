import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  static const String ROUTE_PAGE = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SplashPage'),
      ),
      body: Obx(
        () => Text(
          controller.userLogged.toString(),
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
