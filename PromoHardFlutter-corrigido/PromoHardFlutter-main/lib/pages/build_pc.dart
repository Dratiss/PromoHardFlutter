import 'package:flutter/material.dart';

class BuildPCPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0A0A),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Montar PC",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.35),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xFF121212),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.25),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.build, size: 60, color: Colors.purpleAccent),
              SizedBox(height: 16),
              Text(
                "Sistema em desenvolvimento",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Em breve você poderá montar PCs completos\ncom base no seu orçamento.",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
