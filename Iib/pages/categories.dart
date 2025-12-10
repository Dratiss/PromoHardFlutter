import 'package:flutter/material.dart';
import 'category_products_page.dart';

class CategoriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Placas de Vídeo", "icon": Icons.memory, "color": Colors.greenAccent},
    {"name": "Processadores", "icon": Icons.developer_board, "color": Colors.orangeAccent},
    {"name": "Armazenamento", "icon": Icons.sd_storage, "color": Colors.blueAccent},
    {"name": "Placas-mãe", "icon": Icons.devices, "color": Colors.purpleAccent},
    {"name": "Gabinetes", "icon": Icons.view_in_ar, "color": Colors.redAccent},
    {"name": "Periféricos", "icon": Icons.mouse, "color": Colors.cyanAccent},
    {"name": "Memórias RAM", "icon": Icons.memory_outlined, "color": Colors.yellowAccent},
    {"name": "Fontes", "icon": Icons.power, "color": Colors.lightGreenAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: Color(0xFF0E0E0E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Categorias",
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
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryProductsPage(
                      categoryName: category["name"],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: category["color"].withOpacity(0.25),
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category["icon"], color: category["color"], size: 38),
                    SizedBox(height: 12),
                    Text(
                      category["name"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
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
