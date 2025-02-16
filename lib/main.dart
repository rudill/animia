import 'package:animia/UI/searchAnime.dart';
import 'package:flutter/material.dart';

import 'UI/homeScreen.dart';
import 'UI/mainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: const Scaffold(
        body:
        HomeScreen(),
      )

      // const searchAnime(
      //   aniName: 'Attack on titan',
      //   page: 1,
      //   perPage: 10,
      // ),
    );
  }
}
