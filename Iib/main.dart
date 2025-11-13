import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PromoHard',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF7B1FA2),
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
      ),
      home: HomePage(),
    );
  }
}
