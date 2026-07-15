import 'package:flutter/material.dart';
import 'main.dart'; // Importante: chama as cores do main.dart
import 'pages/home.dart';
import 'pages/categories.dart';
import 'pages/favorites_page.dart';
import 'pages/build_pc.dart';
import 'pages/profile.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final screens = [
    HomePage(),
    CategoriesPage(),
    FavoritesPage(),
    BuildPCPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.navBar, // Fundo ultra escuro da nav bar
          boxShadow: [
            BoxShadow(
              color: AppColors.goldAccent.withOpacity(0.15), // Glow Dourado
              blurRadius: 12,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.goldAccent, // Ícone selecionado Dourado
          unselectedItemColor: Colors.white54,
          elevation: 0,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: AppColors.goldAccent.withOpacity(0.6),
                blurRadius: 8,
              )
            ],
          ),
          selectedIconTheme: IconThemeData(
            size: 28,
            color: AppColors.goldAccent,
            shadows: [
              Shadow(
                color: AppColors.goldAccent.withOpacity(0.7),
                blurRadius: 12,
              )
            ],
          ),
          unselectedIconTheme: const IconThemeData(size: 24),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categorias"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoritos"),
            BottomNavigationBarItem(icon: Icon(Icons.build), label: "Montar PC"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          ],
        ),
      ),
    );
  }
}
