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

/// Report tab of the app. Showcases the result of the speech analysis and the transcript.
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
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Back button at the top left corner.
              _buildBackButton(theme),
              const SizedBox(height: 15),

              // Text UI elements.
              Align(
                alignment: Alignment.centerLeft,
                child: _buildTitle(theme, 'Report', 20),
              ),
              const SizedBox(height: 40),
              _buildProfileImage(theme),
              const SizedBox(height: 15),
              _buildTitle(theme, 'Cat Dev', 15),
              const SizedBox(height: 25),
              _buildTitle(theme, 'Speak Guard', 35, isBold: true),
              _buildTitle(theme, 'SPEECH MODERATION MONITOR', 16),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildTitle(theme, 'RESULT', 20),
              ),
              const SizedBox(height: 15),

              // Result of the analysis
              _buildContent(theme, result, 18),
              const SizedBox(height: 15),

              // Transcript of the user.
              Align(
                alignment: Alignment.centerLeft,
                child: _buildContent(theme, content, 15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the back button at the top left corner to go back to the previous page.
  Widget _buildBackButton(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: BackButton(color: theme.colorScheme.primary),
    );
  }

  /// Builds the profile picture of the user.
  Widget _buildProfileImage(ThemeData theme) {
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

  // Builds text UI element with primary color.
  Widget _buildTitle(ThemeData theme, String text, double size,
      {bool isBold = false}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: theme.colorScheme.primary,
      ),
    );
  }

  // Builds text UI element with onBackground color.
  Widget _buildContent(ThemeData theme, String text, double size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: theme.colorScheme.onBackground,
      ),
    );
  }
}
