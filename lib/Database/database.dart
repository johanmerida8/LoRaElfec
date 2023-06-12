import 'package:mysql1/mysql1.dart';

class DatabaseService {
  late MySqlConnection _connection;

  Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'your_username',
      password: 'your_password',
      db: 'database_name',
    );
    _connection = await MySqlConnection.connect(settings);
    return _connection;
  }

  void closeConnection() async {
    await _connection.close();
  }
}