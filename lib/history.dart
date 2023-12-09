import 'package:flutter/material.dart';

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
                style: TextStyle(
                    fontSize: 20,
                    color: theme
                        .colorScheme.inversePrimary), // Change label color here
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
                    color: theme
                        .colorScheme.onBackground), // Change label color here
              ),
            ),
            // TODO: Fetch recordings
            SizedBox(height: 15),
            HistoryRecording(
              title: 'Test Recording 1',
              duration: '60 sec',
              date: '07.12.2023',
            ),
            SizedBox(height: 15),
            HistoryRecording(
              title: 'Test Recording 2',
              duration: '120 sec',
              date: '07.12.2023',
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

  const HistoryRecording({
    Key? key,
    required this.title,
    required this.date,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Dismissible(
      key: Key('generated_id'),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        // TODO
        // Implement the delete functionality here
        // This function will be called when the item is swiped
        // You can remove the item from your data source
      },
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.all(15),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color:
                    theme.colorScheme.onBackground), // Change label color here
          ),
          subtitle: Text(
            '$date ($duration)',
            style: TextStyle(
                fontSize: 13,
                color:
                    theme.colorScheme.onBackground), // Change label color here
          ),
        ),
      ),
    );
  }
}
