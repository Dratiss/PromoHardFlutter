import 'package:flutter/material.dart';

class BuildPCPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: Color(0xFF0E0E0E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Montar PC",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.20),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: Text(
          "Montador de PC — disponível na 1.1",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      ),
    );
  }
}
