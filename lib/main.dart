import 'package:animia/UI/searchEngine.dart';
import 'package:flutter/material.dart';

import 'UI/homeScreen.dart';
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

    final ThemeData customTheme = ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF0D1622),
        onPrimary: Colors.white,
        surface: Color(0xFF0D1622),
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF0D1622),
      textTheme:  const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
        bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
        displayLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF0D1622),
        textTheme: ButtonTextTheme.primary,
      ),
    );


    return MaterialApp(
        theme: customTheme,
        home:  const Scaffold(
          body: HomeScreen(),
        ));
  }
}
