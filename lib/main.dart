import 'package:flutter/material.dart';

import 'mainScreen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: animaMainScreen(aniId: 895,)
    );
  }
}
