import 'package:flutter/material.dart';
import '../main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E0E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Configurações",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: AppColors.goldAccent.withOpacity(0.20),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),

      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 20, bottom: 8),
            child: Text(
              "Aparência",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.color_lens, color: Colors.white),
            title: const Text("Tema do Aplicativo", style: TextStyle(color: Colors.white)),
            subtitle: const Text("Disponível em breve",
                style: TextStyle(color: Colors.white54, fontSize: 12)),
            onTap: () {},
          ),

          const Divider(color: Colors.white24),

          const Padding(
            padding: EdgeInsets.only(left: 15, top: 20, bottom: 8),
            child: Text(
              "Informações",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.info, color: Colors.white),
            title: const Text("Sobre o Aplicativo", style: TextStyle(color: Colors.white)),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "PromoHard",
                applicationVersion: "1.0",
                applicationIcon: const Icon(Icons.local_offer),
                children: const [
                  Text(
                    "PromoHard — aplicativo de promoções voltado para tecnologia.\n"
                    "Versão 1.0 focada em simplicidade, utilidade e velocidade.",
                  ),
                ],
              );
            },
          ),

          const ListTile(
            leading: Icon(Icons.description, color: Colors.white),
            title: Text("Termos de Uso", style: TextStyle(color: Colors.white)),
            subtitle: Text("Disponível em breve",
                style: TextStyle(color: Colors.white54, fontSize: 12)),
          ),

          const ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.white),
            title: Text("Política de Privacidade", style: TextStyle(color: Colors.white)),
            subtitle: Text("Disponível em breve",
                style: TextStyle(color: Colors.white54, fontSize: 12)),
          ),

          const Divider(color: Colors.white24),

          const Padding(
            padding: EdgeInsets.only(left: 15, top: 20),
            child: Text(
              "Sistema",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),

          const ListTile(
            leading: Icon(Icons.system_update, color: Colors.white),
            title: Text("Versão do App", style: TextStyle(color: Colors.white)),
            subtitle: Text("1.0 (Beta de lançamento)",
                style: TextStyle(color: Colors.white54, fontSize: 12)),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
