import 'package:flutter/material.dart';
import 'history.dart';
import 'settings.dart';

/// Flutter code sample for [NavigationBar].

class Recording extends StatefulWidget {
  const Recording({super.key});

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: theme.colorScheme.inversePrimary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.history_rounded)),
            label: 'History',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.settings),
            ),
            label: 'Settings',
          ),
        ],
      ),
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 35, bottom: 35, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackButton(
                color: theme.colorScheme.inversePrimary,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Speak Guard',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: theme
                      .colorScheme.inversePrimary), // Change label color here
            ),
            Text(
              'Speak into the microphone',
              style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.outline), // Change label color here
            ),
            SizedBox(height: 50),
            Text(
              'Please speak clearly',
              style: TextStyle(
                  fontSize: 10,
                  color: theme.colorScheme.outline), // Change label color here
            ),
          ],
        ),
      ),
    );
  }
}
