import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Views/homepage.dart';
// ignore: unused_import
import 'package:medical_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform).then((value) {
    print("Firebase initialized successfully");
  }).catchError((error) {
    print("Error initializing Firebase: $error");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Color(0xFF001F3F)))),
      home: const HomePage(),
    );
  }
}
