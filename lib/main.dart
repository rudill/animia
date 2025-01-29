import 'package:flutter/material.dart';

import 'mainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: const animaMainScreen(
        aniName: 'chainsaw man',
      ),
    );
  }
}
