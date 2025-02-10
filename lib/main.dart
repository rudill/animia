import 'package:animia/searchAnime.dart';
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
      // home: const animaMainScreen(
      //   aniName: 'Attack on titan',
      // ),
      home:  const searchAnime(
        aniName: 'demon slayer',
        page: 1,
        perPage: 10,
      ),
    );
  }
}
