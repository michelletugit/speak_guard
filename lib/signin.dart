import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/storage/v1.dart' as storage;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'package:provider/provider.dart';
import 'authenticatedClientModel.dart';

void main() => runApp(MyApp());

/// Handles the sign in of the app. Google authentification is used in our case.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Sign-In'),
        ),
        body: SignIn(),
      ),
    );
  }
}

/// Signin class that extends to StatefulWidget for the sign in.
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

/// Sends over API scope and authenticates user.
class _SignInState extends State<SignIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      storage.StorageApi.devstorageReadWriteScope,
      'https://www.googleapis.com/auth/devstorage.read_write',
      'https://www.googleapis.com/auth/sqlservice.admin',
      'https://www.googleapis.com/auth/cloud-platform',
    ],
  );

  /// Calls signIn() to authenticate the user and stores the token and credentials.
  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // final String userId = account.id;
        // final String? userName = account.displayName;
        final authHeaders = await account.authHeaders;
        final authToken = authHeaders['Authorization']!.split(' ').last;
        final expiry = DateTime.now()
            .toUtc()
            .add(Duration(hours: 1)); // Example expiration time

        final AccessCredentials credentials = AccessCredentials(
          AccessToken('Bearer', authToken, expiry),
          null, // Refresh token is not available in this context
          _googleSignIn.scopes,
        );

        final authClient = authenticatedClient(
          http.Client(),
          credentials,
        );

        // Update global state with authenticated client and credentials
        Provider.of<AuthenticatedClientModel>(context, listen: false)
            .updateCredentials(credentials, authClient);

        // Navigate to Home after successful signin.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } catch (error) {
      debugPrint("error");
      debugPrint('error: $error');
      _showSignInError();
    }
  }

  /// An error dialog will be shown in case of error.
  void _showSignInError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign In Failed'),
          content:
              Text('An error occurred while signing in. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _handleSignIn,
        child: Text('Sign in with Google'),
      ),
    );
  }
}
