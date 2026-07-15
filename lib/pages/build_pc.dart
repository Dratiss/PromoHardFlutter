import 'package:flutter/material.dart';
import '../main.dart';

class BuildPCPage extends StatelessWidget {
  const BuildPCPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
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
                color: AppColors.goldAccent.withOpacity(0.35),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.goldAccent.withOpacity(0.25),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.build, size: 60, color: AppColors.goldAccent),
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
