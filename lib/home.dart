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
import 'history.dart';
import 'settings.dart';
import 'recording.dart';
import 'topbar.dart';

/// Home tab of the app.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  /// Builds the bottom navigation bar of the app.
  ///
  /// Allows users to navigate between Home, History and Settings.
  Widget _buildNavigationBar(ThemeData theme) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      indicatorColor: theme.colorScheme.primary,
      selectedIndex: currentPageIndex,
      destinations: const <NavigationDestination>[
        // Home
        NavigationDestination(
          selectedIcon: Icon(Icons.home_rounded),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),

        // History
        NavigationDestination(
          icon: Icon(Icons.history_outlined),
          selectedIcon: Icon(Icons.history_rounded),
          label: 'History',
        ),

        // Settings
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  /// Builds the navigation bar.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      // Add the bottom navigation bar to navigate through Home, History and Settings.
      bottomNavigationBar: _buildNavigationBar(theme),
      body: <Widget>[
        /// Home page
        HomePage(),

        /// History page
        HistoryPage(),

        /// Settings page
        SettingsPage(),
      ][currentPageIndex],
    );
  }
}

/// Represents the home tab above the navigation bar.
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 35, bottom: 35, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Add a TopBar to this page
            TopBar(
              titleText: 'Home',
              theme: Theme.of(context),
            ),
            SizedBox(height: 40),

            // Profile picture
            _buildProfileCircle(theme),
            SizedBox(height: 15),

            Text(
              'Cat Dev',
              style: TextStyle(
                  fontSize: 15, color: theme.colorScheme.inverseSurface),
            ),
            SizedBox(height: 25),
            Text(
              'Speak Guard',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary),
            ),
            Text(
              'SPEECH MODERATION MONITOR',
              style: TextStyle(fontSize: 16, color: theme.colorScheme.outline),
            ),
            SizedBox(height: 50),

            // Record button
            _buildRecordButton(context, theme),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About',
                style: TextStyle(
                    fontSize: 20, color: theme.colorScheme.onBackground),
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome to Speak Guard - where your voice is heard, respected, and protected.\n \nSpeak Guard is your go-to app for ensuring that your spoken words remain in the realm of decency and respect.Our app empowers users to record their voices with confidence, knowing that our technology is on guard against any vulgar or inappropriate language. \n \nWith Speak Guard, you can effortlessly record your thoughts, messages, or conversations. Our goal is to create a space where communication is not only easy but also respectful and inclusive.',
                style: TextStyle(
                    fontSize: 15, color: theme.colorScheme.onBackground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Builds the record button and navigates the user to the recording page after press.
Widget _buildRecordButton(BuildContext context, ThemeData theme) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      minimumSize: const Size(double.infinity, 45),
      backgroundColor: theme.colorScheme.primary,
    ),

    // Navigate user to the recording page after press.
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Recording()),
      );
    },
    child: const Text('Record your Speech'),
  );
}

/// Returns the profile picture in circle.
Widget _buildProfileCircle(ThemeData theme) {
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
