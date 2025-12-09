import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Sobre o App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PromoHard",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Versão 1.0.0",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "A PromoHard foi criada para facilitar a vida de quem busca promoções reais de tecnologia. "
              "Nosso objetivo é reunir ofertas confiáveis em um só lugar, com rapidez, clareza e precisão.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "O app não realiza vendas. Ele apenas redireciona para lojas parceiras.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Criado por Eduardo (PromoHard).",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                "© 2025 PromoHard",
                style: TextStyle(color: Colors.white30, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
