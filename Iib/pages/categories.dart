import 'package:flutter/material.dart';
import 'category_products_page.dart';

class CategoriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Placas de Vídeo", "icon": Icons.memory},
    {"name": "Processadores", "icon": Icons.developer_board},
    {"name": "Armazenamento", "icon": Icons.sd_storage},
    {"name": "Placas-mãe", "icon": Icons.devices},
    {"name": "Gabinetes", "icon": Icons.view_in_ar},
    {"name": "Periféricos", "icon": Icons.mouse},
    {"name": "Memórias RAM", "icon": Icons.memory_outlined},
    {"name": "Fontes", "icon": Icons.power},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0A0A),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Categorias",
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
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CategoryProductsPage(categoryName: category["name"]),
                  ),
                );
              },

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF181818),
                      Color(0xFF101010),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.20),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category["icon"],
                      color: Colors.purpleAccent,
                      size: 40,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      category["name"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
