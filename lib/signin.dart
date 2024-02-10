import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/storage/v1.dart' as storage;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Sign-In Demo'),
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
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final authHeaders = await account.authHeaders;
        final authClient = authenticatedClient(
          http.Client(),
          AccessCredentials(
            AccessToken('Bearer', authHeaders['Authorization']!.split(' ').last,
                DateTime.now().toUtc().add(Duration(hours: 1))),
            null, // Refresh token is not available in this context
            [storage.StorageApi.devstorageReadWriteScope],
          ),
        );

        final storageApi = storage.StorageApi(authClient);

        // Navigate to the Home page if sign-in was successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } catch (error) {
      debugPrint('error: ${error} ');
      // Show an error message if sign-in failed
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
