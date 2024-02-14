import 'package:flutter/foundation.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

/// Helper class for storing client details and managing authentication.
///
/// This class provides methods to update and access the credentials
/// and HTTP client used for authenticated requests.
class AuthenticatedClientModel with ChangeNotifier {
  AccessCredentials? _credentials;
  http.Client? _client;

  /// Gets the current credentials.
  AccessCredentials? get credentials => _credentials;

  /// Gets the current authenticated HTTP client.
  http.Client? get client => _client;

  /// Updates the stored credentials and HTTP client.
  ///
  /// After updating, all listeners are notified of the change.
  ///
  /// [credentials] The new access credentials.
  /// [client] The new HTTP client.
  void updateCredentials(AccessCredentials credentials, http.Client client) {
    _credentials = credentials;
    _client = client;
    notifyListeners();
  }
}
