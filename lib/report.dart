import 'package:flutter/material.dart';

/// Flutter code sample for [NavigationBar].

class Report extends StatelessWidget {
  final int id;

  const Report({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      child: Padding(
        padding: EdgeInsets.only(top: 35, bottom: 35, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(
                  color: theme.colorScheme.primary,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Report',
                  style: TextStyle(
                      fontSize: 20,
                      color:
                          theme.colorScheme.primary), // Change label color here
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
                    color: theme.colorScheme.primary, // Color of the border
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
              SizedBox(height: 25),
              Text(
                'Speak Guard',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color:
                        theme.colorScheme.primary), // Change label color here
              ),
              Text(
                'SPEECH MODERATION MONITOR',
                style: TextStyle(
                    fontSize: 16,
                    color:
                        theme.colorScheme.outline), // Change label color here
              ),
              SizedBox(height: 50),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About',
                  style: TextStyle(
                      fontSize: 20,
                      color: theme
                          .colorScheme.onBackground), // Change label color here
                ),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to Speak Guard - where your voice is heard, respected, and protected.\n \nSpeak Guard is your go-to app for ensuring that your spoken words remain in the realm of decency and respect.Our app empowers users to record their voices with confidence, knowing that our technology is on guard against any vulgar or inappropriate language. \n \nWith Speak Guard, you can effortlessly record your thoughts, messages, or conversations. Our goal is to create a space where communication is not only easy but also respectful and inclusive.',
                  style: TextStyle(
                      fontSize: 15,
                      color: theme
                          .colorScheme.onBackground), // Change label color here
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
