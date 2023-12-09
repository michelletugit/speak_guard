import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
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
                'Settings',
                style: TextStyle(
                    fontSize: 20,
                    color: theme
                        .colorScheme.inversePrimary), // Change label color here
              ),
            ),
            SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(
                  2), // Adjust the padding to control the border width
              decoration: BoxDecoration(
                color: theme.colorScheme.background, // Color of the border
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      theme.colorScheme.inversePrimary, // Color of the border
                  width: 8, // Width of the border
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
                  fontSize: 15,
                  color: theme
                      .colorScheme.inverseSurface), // Change label color here
            ),
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Number of Recordings: 2',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: theme
                        .colorScheme.inverseSurface), // Change label color here
              ),
            ),
            SizedBox(height: 70),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minimumSize: Size(double.infinity, 50),
                backgroundColor: theme.colorScheme.inversePrimary,
              ),
              onPressed: () {},
              child: const Text('Recalibrate Voice'),
            ),
          ],
        ),
      ),
    );
  }
}
