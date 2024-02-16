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

/// This class represents the top bar of all the main tabs.
class TopBar extends StatelessWidget {
  /// [titleText] will be displayed at the top left corner in the primary scheme color.
  final String titleText;

  /// [subtitleText] will be displayed below the titleText in the onBackground scheme color.
  ///
  /// Can be null. Will not be displayed in that case.
  final String? subtitleText;
  final ThemeData theme;

  const TopBar({
    Key? key,
    required this.titleText,
    this.subtitleText,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // titleText display
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            titleText,
            style: TextStyle(fontSize: 20, color: theme.colorScheme.primary),
          ),
        ),
        // subtitleText display
        // Check if subtitleText is not null before displaying it
        if (subtitleText != null) ...[
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              subtitleText!,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground),
            ),
          ),
        ],
      ],
    );
  }
}
