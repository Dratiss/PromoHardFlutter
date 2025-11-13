import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'ui/home/home_page.dart';
import 'ui/categories/categories_page.dart';
import 'ui/favorites/favorites_page.dart';
import 'ui/pc_builder/pc_builder_page.dart';
import 'ui/profile/profile_page.dart';

void main() {
  runApp(const PromoHardApp());
}

class PromoHardApp extends StatefulWidget {
  const PromoHardApp({super.key});

  @override
  State<PromoHardApp> createState() => _PromoHardAppState();
}

class _PromoHardAppState extends State<PromoHardApp> {
  int _selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    CategoriesPage(),
    FavoritesPage(),
    PCBuilderPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PromoHard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF0D0D0D),
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.white60,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
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
