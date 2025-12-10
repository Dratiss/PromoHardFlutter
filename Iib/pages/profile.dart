import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'favorites_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: Color(0xFF0E0E0E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Perfil",
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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.grey[700],
              child: Icon(Icons.person, size: 50, color: Colors.white),
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

            SizedBox(height: 20),
            Divider(color: Colors.white24),

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
              icon: Icons.email_outlined,
              label: "Contato / Suporte",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context,
      {required IconData icon, required String label, Widget? page}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.chevron_right, color: Colors.white54),
      onTap: () {
        if (page != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        }
      },
    );
  }
}
