import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'favorites_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Perfil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 25),

            // FOTO DO USUÁRIO
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.grey[800],
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 14),

            // NOME DO USUÁRIO (placeholder)
            const Text(
              "Usuário PromoHard",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 25),
            Divider(color: Colors.white10),

            const SizedBox(height: 10),

            // LISTA DE OPÇÕES
            buildMenuItem(
              context,
              icon: Icons.favorite,
              label: "Favoritos",
              page: FavoritesPage(),
            ),
            buildMenuItem(
              context,
              icon: Icons.settings,
              label: "Configurações",
              page: SettingsPage(),
            ),
            buildMenuItem(
              context,
              icon: Icons.info_outline,
              label: "Sobre o App",
            ),
            buildMenuItem(
              context,
              icon: Icons.privacy_tip_outlined,
              label: "Política de Privacidade",
            ),
            buildMenuItem(
              context,
              icon: Icons.support_agent,
              label: "Contato / Suporte",
            ),
          ],
        ),
      ),
    );
  }

  // ITEM REUTILIZÁVEL DO MENU
  Widget buildMenuItem(BuildContext context,
      {required IconData icon, required String label, Widget? page}) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent, size: 26),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      onTap: () {
        if (page != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        }
      },
    );
  }
}
