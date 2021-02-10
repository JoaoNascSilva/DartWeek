import 'package:delivery_api/application/entities/menu.dart';
import 'package:delivery_api/repositories/menu/IMenuRepository.dart';
import 'package:delivery_api/services/menu/IMenuService.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IMenuService)
class MenuService implements IMenuService {
  final IMenuRepository _repository;

  MenuService(this._repository);

  @override
  Future<List<Menu>> getAllMenus() {
    return _repository.findAll();
  }
}
