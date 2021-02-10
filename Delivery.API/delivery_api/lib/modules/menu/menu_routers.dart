import 'package:delivery_api/application/Routers/IRouterConfigure.dart';
import 'package:delivery_api/modules/menu/menu_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf_router/src/router.dart';

@injectable
class MenuRouters implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.mount('/menu/', GetIt.I.get<MenuController>().router);
  }
}
