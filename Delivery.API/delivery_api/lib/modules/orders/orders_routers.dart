import 'package:delivery_api/application/Routers/IRouterConfigure.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

import 'controllers/orders_controller.dart';

class OrdersRouters implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.mount('/order/', GetIt.I.get<OrdersController>().router);
  }
}
