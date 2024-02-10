import 'package:flutter/material.dart';
import 'package:speak_guard/stt.dart';
import 'home.dart';
import 'signin.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//import 'stt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speak Guard',
      theme: FlexThemeData.light(scheme: FlexScheme.sakura),
      /*ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xffFFC700),
        ),
        fontFamily: 'Montserrat bold',
      ),*/

      themeMode: ThemeMode.light,
      home: SignIn(),
    );
  }
}
