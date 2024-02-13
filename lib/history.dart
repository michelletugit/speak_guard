import 'package:flutter/material.dart';
import 'report.dart';

class HistoryPage extends StatelessWidget {
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
                'History',
                style:
                    TextStyle(fontSize: 20, color: theme.colorScheme.primary),
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Speech Recordings',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground),
              ),
            ),
            // TODO: Fetch recordings
            SizedBox(height: 15),
            HistoryRecording(
              title: 'Test Recording 1',
              duration: '60 sec',
              date: '07.12.2023',
              id: 1,
              content:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              result: ":)",
            ),
            SizedBox(height: 15),
            HistoryRecording(
              title: 'Test Recording 2',
              duration: '120 sec',
              date: '07.12.2023',
              id: 2,
              content: "You are stupid",
              result: "Harassment",
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryRecording extends StatelessWidget {
  final String title;
  final String date;
  final String duration;
  final int id;
  final String content;
  final String result;

  const HistoryRecording({
    Key? key,
    required this.title,
    required this.date,
    required this.duration,
    required this.id,
    required this.content,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Dismissible(
      key: Key(id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {},
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.all(15),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground),
          ),
          subtitle: Text(
            '$date ($duration)',
            style:
                TextStyle(fontSize: 13, color: theme.colorScheme.onBackground),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Report(content: content, result: result)),
            );
          },
        ),
      ),
    );
  }
}
