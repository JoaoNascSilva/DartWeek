import 'package:delivery_api/application/config/database_connectionconfiguration.dart';
import 'package:delivery_api/application/database/IDatabaseConnection.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/src/single_connection.dart';

@Injectable(as: IDatabaseConnection)
class DatabaseConnection implements IDatabaseConnection {
  final DatabaseConnectionConfiguration _configuration;

  DatabaseConnection(
    this._configuration,
  );

  @override
  Future<MySqlConnection> openConnection() {
    return MySqlConnection.connect(ConnectionSettings(
      host: _configuration.host,
      port: int.parse(_configuration.port),
      user: _configuration.user,
      password: _configuration.password,
      db: _configuration.databasename,
    ));
  }
}
