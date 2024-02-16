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

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'signin.dart';
import 'topbar.dart';

/// Settings tab of the app. Handles sign out and contains dummy button "recalibrate your voice".
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top bar with settings title.
            _buildTopBar(context),
            const SizedBox(height: 40),
            // Display user's profile picture.
            _buildProfileImage(context),
            const SizedBox(height: 15),
            // Display user's name.
            _buildProfileName(context),
            const SizedBox(height: 70),
            // Button for recalibrating voice.
            _buildRecalibrateVoiceButton(context),
            const SizedBox(height: 50),
            // Button to sign out the user.
            _buildSignOutButton(context),
          ],
        ),
      ),
    );
  }

  /// Builds the top bar of the settings page.
  Widget _buildTopBar(BuildContext context) {
    return TopBar(
      titleText: 'Settings',
      theme: Theme.of(context),
    );
  }

  /// Builds and styles the profile image container.
  Widget _buildProfileImage(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 8,
        ),
      ),
      child: const CircleAvatar(
        backgroundImage: AssetImage("assets/profile.jpg"),
        radius: 50,
      ),
    );
  }

  /// Displays the profile name.
  Widget _buildProfileName(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      'Cat Dev',
      style: TextStyle(fontSize: 15, color: theme.colorScheme.inverseSurface),
    );
  }

  /// Button for recalibrating the user's voice.
  Widget _buildRecalibrateVoiceButton(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: theme.colorScheme.primary,
      ),
      onPressed: () {}, // Empty for now.
      child: const Text('Recalibrate Voice'),
    );
  }

  /// Button to sign out the current user.
  Widget _buildSignOutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () => _handleSignOut(context),
      child: const Text('Sign Out'),
    );
  }

  /// Handles the sign-out process using GoogleSignIn and navigates to the sign-in page upon success.
  Future<void> _handleSignOut(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await _googleSignIn.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $error')),
      );
    }
  }
}
