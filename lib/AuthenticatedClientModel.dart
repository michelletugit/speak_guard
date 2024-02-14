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
