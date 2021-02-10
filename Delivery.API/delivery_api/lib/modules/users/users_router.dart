import 'package:delivery_api/application/Routers/IRouterConfigure.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

import 'usercontroller/user_controller.dart';

class UsersRouter implements IRouterConfigure {
  @override
  void configure(Router router) {
    final userController = GetIt.I.get<UserController>();
    router.mount('/user/', userController.router);
  }
}
