import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/categories.dart';
import 'pages/favorites.dart';
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
          color: Color(0xFF141414),
          boxShadow: [
            BoxShadow(
              color: Colors.purpleAccent.withOpacity(0.15),
              blurRadius: 12,
              offset: Offset(0, -4),
            )
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.white54,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.6),
                blurRadius: 8,
              )
            ],
          ),
          selectedIconTheme: IconThemeData(
            size: 28,
            color: Colors.purpleAccent,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.7),
                blurRadius: 12,
              )
            ],
          ),
          unselectedIconTheme: IconThemeData(size: 24),
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
