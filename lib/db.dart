import 'package:postgres/postgres.dart';

class DatabaseHelper {
  final String host = '35.234.79.194';
  final int port = 5432; // Default port for PostgreSQL
  final String databaseName = 'speak-guard-db ';
  final String username = 'postgres';
  final String password = '.EDHR\\CJl{%0,F`*';
  late Connection connection;

  Future<void> connect() async {
    try {
      connection = await Connection.open(
        Endpoint(
          host: host,
          database: databaseName,
          username: username,
          password: password,
        ),
        // The postgres server hosted locally doesn't have SSL by default. If you're
        // accessing a postgres server over the Internet, the server should support
        // SSL and you should swap out the mode with `SslMode.verifyFull`.
        settings: ConnectionSettings(sslMode: SslMode.verifyFull),
      );
      print('has connection!');
    } catch (e) {
      print('Error connecting to the database: $e');
    }
  }

  Future<void> addUserIfNotExists(String userId, String name) async {
    if (!connection.isOpen) {
      await connect();
    }

    // Check if user already exists
    var results = await connection.execute(
      Sql.named('SELECT * FROM users WHERE id=@id'),
      parameters: {'id': userId},
    );

    if (results.isEmpty) {
      // User does not exist, insert new user
      await connection.execute(
        Sql.named('INSERT INTO users (id, name) VALUES (@id, @name)'),
        parameters: {'id': userId, 'name': name},
      );
    }
  }

  Future<void> printAllUsers() async {
    if (!connection.isOpen) {
      await connect();
    }

    var results = await connection.execute('SELECT * FROM users');
    print("Users in the database:");
    for (var row in results) {
      print("ID: ${row[0]}, Name: ${row[1]}");
    }
  }

  Future<void> printAllRecordings() async {
    if (!connection.isOpen) {
      await connect();
    }

    var results = await connection.execute('SELECT * FROM recording');
    print("Users in the database:");
    for (var row in results) {
      print("ID: ${row[0]}, content: ${row[1]}");
    }
  }

  Future<void> disconnect() async {
    await connection.close();
    print('Disconnected from the database');
  }
}
