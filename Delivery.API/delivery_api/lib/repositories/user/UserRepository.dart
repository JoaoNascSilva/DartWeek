import 'package:delivery_api/application/database/IDatabaseConnection.dart';
import 'package:delivery_api/application/entities/user.dart';
import 'package:delivery_api/application/exceptions/databaseErrorExceptions.dart';
import 'package:delivery_api/application/exceptions/user_notfound_exception.dart';
import 'package:delivery_api/modules/users/view_model/register_input_model.dart';
import 'package:delivery_api/modules/users/view_model/user_login_view_model.dart';
import 'package:delivery_api/repositories/user/IUserRepository.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IDatabaseConnection _connection;

  UserRepository(this._connection);

  @override
  Future<void> saveUser(RegisterInputModel inputModel) async {
    final connection = await _connection.openConnection();

    try {
      await connection
          .query('INSERT INTO usuario(nome, email, senha) VALUES (?, ?, ?);', [
        inputModel.name,
        inputModel.email,
        inputModel.password,
      ]);
    } catch (e) {
      print(e);
      throw DataBaseException(message: 'Erro ao registrar  usuario.');
    } finally {
      await connection?.close();
    }
  }

  @override
  Future<User> login(UserLoginModel viewModel) async {
    final connection = await _connection.openConnection();
    try {
      final result = await connection.query(
        '''SELECT id_usuario, nome, email, senha FROM usuario WHERE email = ? AND senha = ?;''',
        [viewModel.email, viewModel.password],
      );

      if (result.isEmpty) throw UserNotFoundException();

      final row = result.first;
      return User(
        id: row['id_usuario'] as int,
        name: row['nome'] as String,
        email: row['email'] as String,
        password: row['senha'] as String,
      );
    } on MySqlException catch (e) {
      print(e);
      throw DataBaseException(message: 'Usuario e/ou senha invalidos.');
    } finally {}
  }
}
