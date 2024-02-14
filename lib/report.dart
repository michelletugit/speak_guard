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

/// Report tab of the app. Showcases the result from the transcript.
class Report extends StatelessWidget {
  /// Content/transcript of the user.
  final String content;

  /// Result from the analysis.
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
                    fontSize: 18, color: theme.colorScheme.onBackground),
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
