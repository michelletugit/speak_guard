import 'package:flutter/material.dart';
import 'signin.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'authenticatedClientModel.dart';

/// Main file for the app.
void main() async {
  // Initialize firebase (currently not used)
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthenticatedClientModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speak Guard',
      theme: FlexThemeData.light(scheme: FlexScheme.sakura),
      themeMode: ThemeMode.light, // Theme set to light.
      home: SignIn(),
    );
  }
}
