import 'package:delivery_api/application/database/IDatabaseConnection.dart';
import 'package:delivery_api/application/entities/menu.dart';
import 'package:delivery_api/application/entities/menu_item.dart';
import 'package:delivery_api/application/exceptions/databaseErrorExceptions.dart';
import 'package:delivery_api/repositories/menu/IMenuRepository.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

@LazySingleton(as: IMenuRepository)
class Menurepository implements IMenuRepository {
  final IDatabaseConnection _connection;

  Menurepository(this._connection);

  @override
  Future<List<Menu>> findAll() async {
    final connection = await _connection.openConnection();

    try {
      final result = await connection.query('SELECT * FROM cardapio_grupo;');

      if (result.isNotEmpty) {
        final menus = result.map<Menu>((row) {
          return Menu(
            id: row['id_cardapio_grupo'] as int,
            name: row['nome_grupo'] as String,
          );
        }).toList();

        for (var menu in menus) {
          final resultItems = await connection.query(
            'SELECT * FROM cardapio_grupo_item WHERE id_cardapio_grupo = ?',
            [menu.id],
          );

          if (resultItems.isNotEmpty) {
            final items = resultItems.map<MenuItem>((row) {
              return MenuItem(
                id: row['id_cardapio_grupo_item'] as int,
                name: row['nome'] as String,
                price: row['valor'] as double,
              );
            }).toList();

            menu.items = items;
          }
        }
        return menus;
      }
      return [];
    } on MySqlException catch (e) {
      print(e);
      throw DataBaseException();
    } finally {
      await connection?.close();
    }
  }
}
