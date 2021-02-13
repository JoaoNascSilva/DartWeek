import 'package:delivery_app/app/modules/home/home_bidings.dart';
import 'package:delivery_app/app/modules/home/home_page.dart';
import 'package:delivery_app/app/modules/login/login_bindings.dart';
import 'package:delivery_app/app/modules/login/login_page.dart';
import 'package:delivery_app/app/modules/registrer/register_bindings.dart';
import 'package:delivery_app/app/modules/registrer/register_page.dart';
import 'package:delivery_app/app/modules/splash/splash_bindings.dart';
import 'package:delivery_app/app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UIConfig {
  UIConfig._();
  static final appTheme = ThemeData(
    primaryColor: Color(0XFF9D0000),
    primarySwatch: Colors.red,
  );

  static const Color colorError = Color(0XFFF9461C);
  static const Color colorInfo = Color(0XFF0086D6);
  static const Color colorSuccess = Color(0XFF43D787);

  static TextStyle isEnableDisableColorText(bool T) {
    final Color colorDisable = Colors.grey[800];
    final Color colorEnable = Colors.white;

    if (T) return TextStyle(color: colorDisable);
    return TextStyle(color: colorEnable);
  }

  static Color isEnableDisableColorButtom(bool T) {
    final Color colorDisable = Colors.grey[400];
    final Color colorEnable = appTheme.primaryColor;

    if (T) return colorDisable;
    return colorEnable;
  }

  static final routes = <GetPage>[
    GetPage(
      name: SplashPage.ROUTE_PAGE,
      page: () => SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: HomePage.ROUTE_PAGE,
      page: () => HomePage(),
      binding: HomeBidings(),
    ),
    GetPage(
      name: LoginPage.ROUTE_PAGE,
      page: () => LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: RegisterPage.ROUTE_PAGE,
      page: () => RegisterPage(),
      binding: RegisterBindings(),
    ),
  ];
}
