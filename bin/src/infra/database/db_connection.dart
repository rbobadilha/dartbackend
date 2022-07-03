import 'package:mysql_client/mysql_client.dart';

import '../../utils/env.dart';
import 'db_config.dart';

class DBConnection implements DBConfig {
  MySQLConnection? _connection;

  @override
  Future<MySQLConnection> get connection async {
    _connection ??= await createConnection();
    if (_connection == null) {
      throw Exception('[ERROR] -> Failed to create connection to the database');
    }
    return _connection!;
  }

  @override
  Future<MySQLConnection?> createConnection() async {
    try {
      MySQLConnection conn = await MySQLConnection.createConnection(
        host: await Env.get(key: 'db_host'),
        port: await Env.get(key: 'db_port'),
        userName: await Env.get(key: 'db_userName'),
        password: await Env.get(key: 'db_password'),
        databaseName: await Env.get(key: 'db_databaseName'),
        secure: false,
      );
      await conn.connect();
      return conn;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  execute(String sql, [Map<String, dynamic>? params]) async {
    var conn = await connection;
    return await conn.execute(sql, params);
  }
}
