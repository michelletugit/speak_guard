import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/storage/v1.dart' as storage;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'package:provider/provider.dart';
import 'AuthenticatedClientModel.dart';

void main() => runApp(MyApp());

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

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      storage.StorageApi.devstorageReadWriteScope,
      'https://www.googleapis.com/auth/devstorage.read_write',
      'https://www.googleapis.com/auth/sqlservice.admin',
      'https://www.googleapis.com/auth/cloud-platform',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
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

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } catch (error) {
      debugPrint('error: $error');
      _showSignInError();
    }
  }

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
                Navigator.of(context).pop(); // Dismiss the dialog
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
