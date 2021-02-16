import 'package:delivery_app/app/modules/home/home_page.dart';
import 'package:delivery_app/app/modules/orders/orders_page.dart';
import 'package:delivery_app/app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PizzaDeliveryBottomNavigation extends StatelessWidget {
  final int _currentIndex;

  const PizzaDeliveryBottomNavigation(this._currentIndex, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Pedidos'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesome.sign_out), label: 'Sair'),
      ],
      onTap: (index) async {
        switch (index) {
          case 0:
            Get.offAllNamed(HomePage.ROUTE_PAGE);
            break;
          case 1:
            Get.offAllNamed(OrdersPage.ROUTE_PAGE);
            break;
          case 2:
            final sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.clear();
            Get.offAllNamed(SplashPage.ROUTE_PAGE);
            break;
        }
      },
    );
  }
}
