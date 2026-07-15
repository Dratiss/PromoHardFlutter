import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0A0A),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Sobre o App",
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PromoHard",
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 12),

              Text(
                "O PromoHard é um aplicativo voltado exclusivamente para promoções de tecnologia, focado em ofertas reais, rápidas e organizadas.",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),

              SizedBox(height: 20),

              Text(
                "Versão 1.0 (Beta de Lançamento)",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),

              SizedBox(height: 6),

              Text(
                "Criado para ser simples, leve, rápido e útil. Em versões futuras, o app receberá muito mais recursos como: montar PC completo, alertas personalizados e filtros avançados.",
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),

              Spacer(),

              Center(
                child: Text(
                  "© 2025 PromoHard",
                  style: TextStyle(color: Colors.white24, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
