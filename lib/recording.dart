import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';

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
                  style: TextStyle(
                      fontSize: 15,
                      color:
                          theme.colorScheme.outline), // Change label color here
                ),
                SizedBox(height: 5),
                Text(
                  'Recognized words:',
                  style: TextStyle(
                      fontSize: 15,
                      color:
                          theme.colorScheme.outline), // Change label color here
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
              uploadData();
              /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Recording()),
              );*/
            },
          ),
        ),
      ),
    );
  }
}

Future<void> uploadData() async {
  // file_picker package
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(
        result.files.single.path!); // Assuming the user picks a single file

    // Create a storage reference from our app
    String fileName = result.files.single.name;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child(fileName); // Use the picked file's name

    try {
      await storageRef.putFile(file);
      final String downloadUrl = await storageRef.getDownloadURL();
      debugPrint('Download URL: $downloadUrl');
    } on FirebaseException catch (e) {
      debugPrint('Error uploading file: $e');
    }
  } else {
    // User canceled the picker
    debugPrint("No file selected");
  }

  /*
  debugPrint("fullPath:" +
      storageRef.fullPath +
      " " +
      "bucket:" +
      storageRef.bucket +
      " " +
      "name:" +
      storageRef.name); */
}
