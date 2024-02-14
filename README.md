# Speak Guard

Speak Guard is a Flutter application to analyze users' speech through AI technology provided by Google. This application aims to transcribe spoken words in real time and then classify the transcript using AI, providing users with insights into their speech patterns.

## Features

- Voice Recording: Users can record their voice directly within the app using a simple and intuitive interface.
- Real-Time Transcription: Speech is transcribed in real-time, allowing users to see the transcript of their spoken words immediately.
- AI-Powered Analysis: The transcribed text is analyzed and classified by AI.
- Google Authentification: This app uses google authentification to authorise users.

## Build Process

- Make sure you have the latest version of Flutter installed. If not, visit [Flutter](https://docs.flutter.dev/get-started/install) for Installation.
- Navigate to the project directory: `cd speak-guard`.
- Install all dependencies: `flutter pub get`.
- For Android, ensure you have an Emulator set up or a physical device connected. This app was tested on an Android Emulator (Pixel 3a API 34, extension level 7, x86_64).
- Run the app with `flutter run`.

## Bugs

As this project is part of an academic thesis, it has undergone limited testing, primarily on an Android emulator (Pixel 3a API 34, extension level 7, x86_64). Users may encounter unexpected behavior or bugs. 

## Workarounds

- Test User Access: Access to a test user account is restricted and can be requested by contacting the author directly. This is to ensure the safety of users and for experiencing the app without individual API credentials.

## 3rd-Party Software

Speak Guard relies on the following third-party libraries and APIs:
- Flutter for the application framework.
- [Speech-to-text](https://pub.dev/packages/speech_to_text) technology provided by [Csdcorp](https://csdcorp.com/).
- [Google Cloud Vertex AI](https://cloud.google.com/vertex-ai?hl=en) for text analysis.
- Other libraries for UI elements, networking, and authentification. See pubspec.yaml for a full list of dependencies.

## Usage
- Start Recording: Press the recording button to start recording your speech.
- Stop Recording: Press the stop button once you've finished speaking. 
- Analyse: Press the analyse button to request a report.
- View Analysis: The AI analysis will be presented, showing the classification of your speech.

## Author
Michelle Lau (e11917662@student.tuwien.ac.at)

## Acknowledgments

This project was developed as part of a bachelor's thesis at the University of Technology Vienna. Special thanks to my supervisor Horst Eidenberger for guidance and support throughout the project.


