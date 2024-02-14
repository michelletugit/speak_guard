import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'signin.dart';

/// Settings tab of the app. Handles sign out and contains dummy button "recalibrate your voice".
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    void _handleSignOut() async {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      try {
        await _googleSignIn.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      } catch (error) {
        print("Error signing out: $error");
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 35, bottom: 35, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Settings',
                style:
                    TextStyle(fontSize: 20, color: theme.colorScheme.primary),
              ),
            ),
            SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 8,
                ),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/profile.jpg"),
                radius: 50,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Cat Dev',
              style: TextStyle(
                  fontSize: 15, color: theme.colorScheme.inverseSurface),
            ),
            SizedBox(height: 70),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minimumSize: Size(double.infinity, 50),
                backgroundColor: theme.colorScheme.primary,
              ),
              onPressed: () {},
              child: const Text('Recalibrate Voice'),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: _handleSignOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
