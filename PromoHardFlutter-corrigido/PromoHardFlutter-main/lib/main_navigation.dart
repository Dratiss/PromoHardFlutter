import 'package:flutter/material.dart';
import 'main.dart';
import 'pages/home.dart';
import 'pages/categories.dart';
import 'pages/favorites_page.dart';
import 'pages/build_pc.dart';
import 'pages/profile.dart';

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
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
          color: AppColors.navBar,
          boxShadow: [
            BoxShadow(
              color: AppColors.goldAccent.withOpacity(0.15),
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
          selectedItemColor: AppColors.goldAccent,
          unselectedItemColor: Colors.white54,
          elevation: 0,
          selectedIconTheme: IconThemeData(
            size: 28,
            shadows: [
              Shadow(
                color: AppColors.goldAccent.withOpacity(0.7), // Efeito Glow na aba ativa
                blurRadius: 12,
              )
            ],
          ),
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