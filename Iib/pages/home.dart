import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> promotions = [
    {
      "title": "RTX 4060 8GB",
      "normal": "R\$ 1.899",
      "promo": "R\$ 1.499",
      "store": "Kabum",
      "image": "https://via.placeholder.com/150"
    },
    {
      "title": "Ryzen 5 5600G",
      "normal": "R\$ 899",
      "promo": "R\$ 649",
      "store": "Amazon",
      "image": "https://via.placeholder.com/150"
    },
    {
      "title": "SSD 1TB NVMe",
      "normal": "R\$ 399",
      "promo": "R\$ 279",
      "store": "Terabyte",
      "image": "https://via.placeholder.com/150"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Promoções em tempo real",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: promotions.length,
        itemBuilder: (context, index) {
          final p = promotions[index];

          return Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Imagem do produto
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.redAccent,
                    child: Image.network(
                      p["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 15),

                // Infos do produto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p["title"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "De: ${p["normal"]}",
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                      Text(
                        "Por: ${p["promo"]}",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        p["store"],
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // Barra inferior
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF141414),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Início",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: "Categorias",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favoritos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: "Montar PC",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Perfil",
            ),
          ],
        ),
      ),
    );
  }
}
