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
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: promotions.length,
        itemBuilder: (context, index) {
          final p = promotions[index];

          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                // IMAGEM DO PRODUTO
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: 85,
                    height: 85,
                    color: Colors.redAccent,
                    child: Image.network(
                      p["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 16),

                // TEXTOS DO CARD
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p["title"],
                        style: TextStyle(
                          fontSize: 17,
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
                          fontSize: 18,
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
    );
  }
}
