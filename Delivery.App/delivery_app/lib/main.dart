import 'package:delivery_app/app/config/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/config/application_bindings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: UIConfig.appTheme,
      getPages: UIConfig.routes,
      initialBinding: ApplicationBindings(),
    );
  }
}
