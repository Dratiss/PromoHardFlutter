import 'package:flutter/material.dart';
import 'pages/splash_page.dart';

// Centralizando a Paleta de Cores Premium
class AppColors {
  static const Color background = Color(0xFF0E0E0E); // Fundo geral (quase preto)
  static const Color navBar = Color(0xFF0A0A0A);     // Fundo das AppBars e BottomNav
  static const Color card = Color(0xFF151515);       // Cinza grafite premium pros cards
  static const Color goldAccent = Color(0xFFD4AF37); // Cor de destaque (Dourado metálico)
  static const Color promoGreen = Color(0xFF2ECC71); // Verde para preços promocionais
  static const Color blueAccent = Colors.blueAccent; // Azul para o nome das lojas
  static const Color redAccent = Colors.redAccent;   // Vermelho para preços antigos/estoque
}

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
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.navBar,
          elevation: 0, // Sem elevação conforme você pediu
          centerTitle: true,
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.goldAccent,
          secondary: AppColors.goldAccent,
          background: AppColors.background,
          surface: AppColors.card,
        ),
      ),
      home: SplashPage(),
    );
  }
}