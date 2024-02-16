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
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:provider/provider.dart';
import 'authenticatedClientModel.dart';
import 'package:googleapis/storage/v1.dart' as storage;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'report.dart';

/// Recording tab of the app.
///
/// This page includes speech to text and communicates with the Google Vertex AI API.
class Recording extends StatefulWidget {
  const Recording({super.key});

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  SpeechToText _speechToText = SpeechToText();

  /// Displayed transcription
  String _lastWords = '';

  /// Confidence value of the transcript
  double _confidence = 1.0;

  @override
  void initState() {
    print("initState");
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    print("_initSpeech");
    await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
        onResult: _onSpeechResult,
        pauseFor: Duration(
          seconds: 10,
        ));
  }

  /// Manually stop the active speech recognition session
  void _stopListening() async {
    await _speechToText.stop();
    print("stopped listening");
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      // Set state of _lastWords
      _lastWords = result.recognizedWords;
      print(result.hasConfidenceRating);

      // Set confidence value
      if (result.hasConfidenceRating && result.confidence > 0) {
        print("set confidence");
        _confidence = result.confidence;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      child: Padding(
        padding: EdgeInsets.only(top: 35, bottom: 35, left: 20, right: 20),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Back button that navigates the user back to home.
                _buildBackButton(theme),
                SizedBox(height: 40),

                // UI elements
                ..._buildTextWidgets(theme),
                SizedBox(height: 20),

                // Recording button
                _buildRecordingButton(theme),

                SizedBox(height: 20),

                // Update confidence value and recognized words.
                ..._buildConfidenceAndWords(theme),
              ],
            ),
          ),
          floatingActionButton: _buildAnalyseButton(context),
        ),
      ),
    );
  }

  /// Builds backbutton to go back to the previous page.
  Widget _buildBackButton(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: BackButton(color: theme.colorScheme.primary),
    );
  }

  /// Builds the UI text elements of the recording page.
  ///
  /// Displays the audio wave in GIF format while STT is transcribing.
  List<Widget> _buildTextWidgets(ThemeData theme) {
    return [
      Text(
        'Speak Guard',
        style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary),
      ),
      Text(
        'Speak into the microphone',
        style: TextStyle(fontSize: 16, color: theme.colorScheme.outline),
      ),
      SizedBox(height: 50),
      Text(
        'Please speak clearly',
        style: TextStyle(fontSize: 10, color: theme.colorScheme.outline),
      ),
      SizedBox(height: 20),
      // Show audiowave.gif if STT is listening / user is speaking.
      if (_speechToText.isListening) Image.asset("assets/audiowave.gif"),
      SizedBox(height: 20),
    ];
  }

  /// Builds the recording button and adjusts the button icon.
  ///
  /// Toggles listening based on whether stt is listening right now.
  Widget _buildRecordingButton(ThemeData theme) {
    return ElevatedButton(
      onPressed: _speechToText.isListening ? _stopListening : _startListening,
      child: Icon(
          _speechToText.isListening ? Icons.pause : Icons.play_arrow_rounded),
    );
  }

  /// Builds and showcases the confidence value and transcribed words in UI elements.
  List<Widget> _buildConfidenceAndWords(ThemeData theme) {
    return [
      Text(
        // Showcase confidence value in percentage.
        'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
        style: TextStyle(fontSize: 15, color: theme.colorScheme.outline),
      ),
      SizedBox(height: 5),
      Text(
        'Recognized words:',
        style: TextStyle(fontSize: 15, color: theme.colorScheme.outline),
      ),
      SizedBox(height: 5),
      // Live transcription.
      Text(
        _lastWords,
        style: TextStyle(fontSize: 14, color: theme.colorScheme.outline),
      ),
      SizedBox(height: 20),
    ];
  }

  /// Builds the analyse button.
  ///
  /// Calls classifyArticle on pressed, which calls the Google API.
  Widget _buildAnalyseButton(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text('analyze'),
      onPressed: () {
        // classifyArticle to analyse speech.
        classifyArticle(context, _lastWords);
      },
    );
  }
}

/// Uploads a test txt file to the Google Cloud Storage. (Not used as of now)
Future<void> uploadData(BuildContext context, String content) async {
  if (content.isEmpty) {
    print('No recognized words');
  }

  final model = Provider.of<AuthenticatedClientModel>(context, listen: false);
  final http.Client? client = model.client;

  const String bucketName = 'speak_guard_bucket';
  const String objectName = 'test.txt';
  String contentType = 'text/plain'; // MIME type for a text file

  if (client != null) {
    final storageApi = storage.StorageApi(client);
    final media = storage.Media(
        http.ByteStream.fromBytes(content.codeUnits), content.length,
        contentType: contentType);

    // Prepare the upload request
    final insertRequest = storage.Object()
      ..name = objectName
      ..contentType = contentType;

    // Execute the upload
    await storageApi.objects
        .insert(insertRequest, bucketName, uploadMedia: media);

    print('File uploaded successfully');
  } else {
    debugPrint("Error with client data");
  }
}

/// Makes an API call to Google Cloud API to classify the user's transcript.
Future<void> classifyArticle(BuildContext context, String content) async {
  final model = Provider.of<AuthenticatedClientModel>(context, listen: false);
  final http.Client? client = model.client;

  // Check if client is authenticated.
  if (client == null) {
    print("Client is not authenticated.");
    return;
  }

  const projectId = "vast-collective-413319";
  const region = "us-central1";

  // Google Vertex AI API url.
  String url =
      'https://$region-aiplatform.googleapis.com/v1/projects/$projectId/locations/$region/publishers/google/models/gemini-pro:streamGenerateContent';

  Map<String, dynamic> requestBody = {
    "contents": [
      {
        "role": "user",
        "parts": [
          {
            "text":
                "Multi-choice problem: Which of the following categories can be identified in the text?\n"
                    "Political incorrectness\n"
                    "Sexism\n"
                    "Racism\n"
                    "swear words\n"
                    "Hate\n"
                    "Harassment\n\n"
                    "Text: $content"
          }
        ]
      }
    ],
    "generation_config": {
      "maxOutputTokens": 256,
      "temperature": 0.2,
      "topP": 0.8,
      "topK": 40
    },

    // safety settings set to "BLOCK_ONLY_HIGH" so that the AI model accepts vulgar phrases.
    "safetySettings": [
      {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_ONLY_HIGH"},
      {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "threshold": "BLOCK_ONLY_HIGH"
      },
      {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "threshold": "BLOCK_ONLY_HIGH"
      },
      {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_ONLY_HIGH"}
    ]
  };

  try {
    // Wait for the API response.
    final response = await client.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);

      // Get the result value of the analysis.
      if (responseJson.isNotEmpty) {
        var candidates = responseJson[0]['candidates'];
        if (candidates.isNotEmpty) {
          var jsoncontent = candidates[0]['content'];
          var parts = jsoncontent['parts'];
          if (parts.isNotEmpty) {
            // JSON extracted value
            var result = parts[0]['text'];
            print("Extracted value: $result");
            if (result == "None of the above") {
              result = ":)";
            }
            print(content);

            // Navigate to Report after result response.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Report(content: content, result: result),
              ),
            );
          }
        }
      }
    } else {
      print("Failed to classify article. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  } catch (e) {
    print("Error calling Vertex AI: $e");
  }
}
