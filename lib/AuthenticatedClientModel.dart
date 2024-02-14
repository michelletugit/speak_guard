import 'package:flutter/foundation.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

/// Helperclass for storing client details.
class AuthenticatedClientModel with ChangeNotifier {
  AccessCredentials? _credentials;
  http.Client? _client;

  AccessCredentials? get credentials => _credentials;
  http.Client? get client => _client;

  /// Updates the credentials.
  void updateCredentials(AccessCredentials credentials, http.Client client) {
    _credentials = credentials;
    _client = client;
    notifyListeners();
  }
}
