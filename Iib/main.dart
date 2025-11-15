import 'package:flutter/material.dart';
import 'main_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PromoHard',

      // Tema escuro padrão
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF7B1FA2),
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
      ),

      // A tela inicial agora é a navegação principal com 5 abas
      home: MainNavigation(),
    );
  }
}
