import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      body: Center(
        child: Text(
          "Favoritos",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
