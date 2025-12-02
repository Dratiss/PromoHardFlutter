import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  // Lista de categorias da PromoHard
  final List<Map<String, dynamic>> categories = [
    {"name": "Processadores", "icon": Icons.memory},
    {"name": "Placas de Vídeo", "icon": Icons.videogame_asset},
    {"name": "Placas-mãe", "icon": Icons.developer_board},
    {"name": "RAM", "icon": Icons.sd_storage},
    {"name": "Armazenamento", "icon": Icons.storage},
    {"name": "Fontes", "icon": Icons.bolt},
    {"name": "Gabinetes", "icon": Icons.dashboard_customize},
    {"name": "Coolers", "icon": Icons.ac_unit},
    {"name": "Monitores", "icon": Icons.monitor},
    {"name": "Periféricos", "icon": Icons.headset},
    {"name": "Consoles", "icon": Icons.sports_esports},
    {"name": "Outros", "icon": Icons.category},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Color(0xFF0E0E0E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Categorias",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,        // duas colunas
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final item = categories[index];
            return _buildCategoryCard(context, item);
          },
        ),
      ),
    );
  }

  // Cartão individual de categoria
  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        // ▸ No futuro vamos integrar aqui para filtrar promoções por categoria
        // ▸ Exemplo:
        // Navigator.push(context, MaterialPageRoute(builder: (_) => PromoFilteredPage(category: item["name"])));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.05),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item["icon"],
              color: Colors.white.withOpacity(0.85),
              size: 38,
            ),
            SizedBox(height: 12),
            Text(
              item["name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
