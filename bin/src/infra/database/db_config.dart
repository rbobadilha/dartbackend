abstract class DBConfig {
  Future<dynamic> createConnection();

  Future<dynamic> get connection;

  execute(String sql, [Map<String, dynamic>? params]);
}
