import 'package:flutter/material.dart';
import 'package:note_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black87,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white30),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
