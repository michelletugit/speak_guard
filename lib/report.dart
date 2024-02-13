import 'package:flutter/material.dart';

/// Flutter code sample for [NavigationBar].

class Report extends StatelessWidget {
  final String content;
  final String result;

  const Report({Key? key, required this.content, required this.result})
      : super(key: key);

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
                style:
                    TextStyle(fontSize: 16, color: theme.colorScheme.outline),
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'RESULT',
                  style: TextStyle(
                      fontSize: 20, color: theme.colorScheme.onBackground),
                ),
              ),
              SizedBox(height: 15),
              Text(
                result,
                style: TextStyle(
                    fontSize: 15, color: theme.colorScheme.onBackground),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  content,
                  style: TextStyle(
                      fontSize: 15, color: theme.colorScheme.onBackground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
