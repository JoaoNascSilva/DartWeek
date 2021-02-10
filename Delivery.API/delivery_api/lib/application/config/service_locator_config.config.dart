// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../database/DatabaseConnection.dart';
import 'database_connectionconfiguration.dart';
import '../database/IDatabaseConnection.dart';
import '../../repositories/menu/IMenuRepository.dart';
import '../../services/menu/IMenuService.dart';
import '../../repositories/user/IUserRepository.dart';
import '../../services/user/IUserService.dart';
import '../../modules/menu/menu_controller.dart';
import '../../modules/menu/menu_routers.dart';
import '../../services/menu/MenuService.dart';
import '../../repositories/menu/MenuRepository.dart';
import '../../modules/users/usercontroller/user_controller.dart';
import '../../repositories/user/UserRepository.dart';
import '../../services/user/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<IDatabaseConnection>(
      () => DatabaseConnection(get<DatabaseConnectionConfiguration>()));
  gh.lazySingleton<IMenuRepository>(
      () => Menurepository(get<IDatabaseConnection>()));
  gh.lazySingleton<IMenuService>(() => MenuService(get<IMenuRepository>()));
  gh.lazySingleton<IUserRepository>(
      () => UserRepository(get<IDatabaseConnection>()));
  gh.lazySingleton<IUserService>(() => UserService(get<IUserRepository>()));
  gh.factory<MenuController>(() => MenuController(get<IMenuService>()));
  gh.factory<MenuRouters>(() => MenuRouters());
  gh.factory<UserController>(() => UserController(get<IUserService>()));
  return get;
}
