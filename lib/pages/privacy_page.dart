import 'package:flutter/material.dart';
import '../main.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Política de Privacidade",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sua privacidade",
              style: TextStyle(
                color: AppColors.goldAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "O PromoHard é um aplicativo de divulgação de promoções de "
              "tecnologia. Ele não solicita cadastro, login, nem coleta dados "
              "pessoais como nome, e-mail ou telefone.",
              style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
            ),
            SizedBox(height: 16),
            Text(
              "Dados armazenados no aparelho",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "As promoções que você marca como favoritas ficam salvas apenas "
              "no seu próprio dispositivo e não são enviadas para nenhum "
              "servidor.",
              style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
            ),
            SizedBox(height: 16),
            Text(
              "Links externos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Ao tocar em \"Ir para a oferta\", você é levado ao site da loja "
              "responsável pela promoção. O PromoHard não se responsabiliza "
              "pelo conteúdo, preços ou disponibilidade nesses sites.",
              style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
            ),
            SizedBox(height: 24),
            Text(
              "Versão 1.0 — este texto pode ser atualizado em versões futuras.",
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
