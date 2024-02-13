import 'package:flutter/material.dart';
import 'history.dart';
import 'settings.dart';
import 'recording.dart';

/// Flutter code sample for [NavigationBar].

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        indicatorColor: theme.colorScheme.primary,
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
              child: Text(
                'Home',
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                minimumSize: Size(double.infinity, 45),
                backgroundColor: theme.colorScheme.primary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Recording()),
                );
              },
              child: const Text('Record your Speech'),
            ),
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
