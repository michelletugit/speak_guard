import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:provider/provider.dart';
import 'AuthenticatedClientModel.dart';
import 'package:googleapis/storage/v1.dart' as storage;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'report.dart';

/// Flutter code sample for [NavigationBar].

class Recording extends StatefulWidget {
  const Recording({super.key});

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  // TODO update _words one last time before sending to the server
  String _words = '';
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
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
        onResult: _onSpeechResult,
        pauseFor: Duration(
          seconds: 10,
        ));
    setState(() {
      _words += '\n$_lastWords';
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    print("stopped listening");
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      print(result.hasConfidenceRating);
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Speak Guard',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color:
                          theme.colorScheme.primary), // Change label color here
                ),
                Text(
                  'Speak into the microphone',
                  style: TextStyle(
                      fontSize: 16,
                      color:
                          theme.colorScheme.outline), // Change label color here
                ),
                SizedBox(height: 50),
                Text(
                  'Please speak clearly',
                  style: TextStyle(
                      fontSize: 10,
                      color:
                          theme.colorScheme.outline), // Change label color here
                ),
                SizedBox(height: 20),
                if (_speechToText
                    .isListening) // Conditional display based on _showImage value
                  Image.asset(
                    "assets/audiowave.gif",
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      // If not yet listening for speech start, otherwise stop
                      _speechToText.isNotListening
                          ? _startListening
                          : _stopListening,
                  child: Icon(_speechToText.isNotListening
                      ? Icons.pause
                      : Icons.play_arrow_rounded),
                ),
                SizedBox(height: 20),
                Text(
                  'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
                  style:
                      TextStyle(fontSize: 15, color: theme.colorScheme.outline),
                ),
                SizedBox(height: 5),
                Text(
                  'Recognized words:',
                  style:
                      TextStyle(fontSize: 15, color: theme.colorScheme.outline),
                ),
                SizedBox(height: 5),
                Text(
                  _lastWords,
                  style:
                      TextStyle(fontSize: 14, color: theme.colorScheme.outline),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text('analyze'),
            onPressed: () {
              classifyArticle(context, _lastWords);
            },
          ),
        ),
      ),
    );
  }
}

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

Future<void> classifyArticle(BuildContext context, String content) async {
  final model = Provider.of<AuthenticatedClientModel>(context, listen: false);
  final http.Client? client = model.client;

  if (client == null) {
    print("Client is not authenticated.");
    return;
  }

  const projectId = "vast-collective-413319";
  const region = "us-central1";
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
                    "political incorrectness\n"
                    "sexism\n"
                    "racism\n"
                    "swear words\n"
                    "hate\n"
                    "harassment\n\n"
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
    final response = await client.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);

      if (responseJson.isNotEmpty) {
        var candidates = responseJson[0]['candidates'];
        if (candidates.isNotEmpty) {
          var jsoncontent = candidates[0]['content'];
          var parts = jsoncontent['parts'];
          if (parts.isNotEmpty) {
            var result = parts[0]['text'];
            print("Extracted value: $result");
            if (result == "None of the above") {
              result = ":)";
            }
            print(content);

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
