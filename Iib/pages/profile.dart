import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'favorites_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Perfil",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.35),
                blurRadius: 10,
              )
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF131313),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.25),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                children: [
                  // FOTO DO USUÁRIO
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.grey[700],
                    child: Icon(Icons.person, size: 55, color: Colors.white),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Usuário PromoHard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Conta básica",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            buildMenuSection("Minha Conta"),
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

            SizedBox(height: 20),

            buildMenuSection("Informações"),
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
              icon: Icons.email_outlined,
              label: "Contato / Suporte",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context,
      {required IconData icon, required String label, Widget? page}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.white54),
        onTap: () {
          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          }
        },
      ),
    );
  }
}
