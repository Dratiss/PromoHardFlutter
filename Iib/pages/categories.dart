import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Hardware",
      "items": [
        "Placas de Vídeo",
        "Processadores",
        "Placas-Mãe",
        "Memória RAM",
        "Armazenamento",
        "Gabinetes",
        "Fontes"
      ]
    },
    {
      "title": "Periféricos",
      "items": [
        "Teclados",
        "Mouses",
        "Headsets",
        "Monitores",
        "Mousepads"
      ]
    },
    {
      "title": "Consoles",
      "items": [
        "PlayStation",
        "Xbox",
        "Nintendo Switch",
        "Acessórios"
      ]
    },
    {
      "title": "Outros",
      "items": [
        "Cadeiras Gamer",
        "Iluminação RGB",
        "Som e Áudio"
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      appBar: AppBar(
        title: Text("Categorias"),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];

          return Container(
            margin: EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.purpleAccent.withOpacity(0.12),
                  spreadRadius: 1,
                  blurRadius: 12,
                ),
              ],
            ),

            child: ExpansionTile(
              collapsedIconColor: Colors.white70,
              iconColor: Colors.purpleAccent,
              title: Text(
                cat["title"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              children: [
                for (String item in cat["items"])
                  ListTile(
                    title: Text(
                      item,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    onTap: () {
                      // Aqui futuramente vamos filtrar as promoções pela categoria
                    },
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
