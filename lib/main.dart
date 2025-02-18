import 'package:animia/UI/homeScreen.dart';
import 'package:flutter/material.dart';
//
// import 'UI/trendingAnime.dart';
// import 'UI/mainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: const Scaffold(
        body:
        SearchAnime(),
      )


    );
  }
}
