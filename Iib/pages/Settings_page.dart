import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0E0E0E),
        elevation: 0,
        title: Text(
          "Configurações",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color(0xFF0E0E0E),
      body: ListView(
        children: [
          // ==============================
          // SEÇÃO: Aparência
          // ==============================
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20, bottom: 8),
            child: Text(
              "Aparência",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.color_lens, color: Colors.white),
            title: Text("Tema do Aplicativo", style: TextStyle(color: Colors.white)),
            subtitle: Text(
              "Disponível em breve",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            onTap: () {},
          ),

          Divider(color: Colors.white24),

          // ==============================
          // SEÇÃO: Informações
          // ==============================
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20, bottom: 8),
            child: Text(
              "Informações",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.info, color: Colors.white),
            title: Text("Sobre o Aplicativo", style: TextStyle(color: Colors.white)),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "PromoHard",
                applicationVersion: "1.0",
                applicationIcon: Icon(Icons.local_offer_rounded),
                children: [
                  Text(
                    "PromoHard é um aplicativo de promoções voltado para tecnologia.\n"
                    "Versão 1.0 — lançada com foco em velocidade, simplicidade e utilidade.",
                  ),
                ],
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.description, color: Colors.white),
            title: Text("Termos de Uso", style: TextStyle(color: Colors.white)),
            subtitle: Text(
              "Disponível em breve",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.white),
            title: Text("Política de Privacidade", style: TextStyle(color: Colors.white)),
            subtitle: Text(
              "Disponível em breve",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            onTap: () {},
          ),

          Divider(color: Colors.white24),

          // ==============================
          // SEÇÃO: Versão
          // ==============================
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20),
            child: Text(
              "Sistema",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.system_update, color: Colors.white),
            title: Text("Versão do App", style: TextStyle(color: Colors.white)),
            subtitle: Text(
              "1.0 (Beta de lançamento)",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            onTap: () {},
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}
