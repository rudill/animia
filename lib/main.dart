import 'package:animia/UI/homeScreen.dart';
import 'package:flutter/material.dart';

import 'UI/TrendingSlider.dart';
//
// import 'UI/trendingAnime.dart';
// import 'UI/mainScreen.dart';

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
          body: TrendingSlider(),
        ));
  }
}
