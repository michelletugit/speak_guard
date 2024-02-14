// Copyright (C) 2024 Michelle Lau
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:postgres/postgres.dart';

/// Class for establishing a connection to the database.
class DatabaseHelper {
  final String host = '35.234.79.194';
  final int port = 5432; // Default port for PostgreSQL
  final String databaseName = 'speak-guard-db ';
  final String username = 'postgres';
  final String password = 'pw'; // Password is safely stored right now.
  late Connection connection;

  /// Establishes a connection to the database.
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

  /// Queries the database and adds a User with [userId] and [name] if it does not exist yet.
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

  /// Queries the database and prints all existing users.
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

  /// Queries the database and prints all existing recordings.
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

  /// Disconnect the client from the database.
  Future<void> disconnect() async {
    await connection.close();
    print('Disconnected from the database');
  }
}
