import 'package:flutter/material.dart';
import '../services/promo_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PromoService promoService = PromoService();
  late Future<List<dynamic>> promotions;

  @override
  void initState() {
    super.initState();
    promotions = promoService.fetchPromotions();
  }

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

      body: FutureBuilder<List<dynamic>>(
        future: promotions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar promoções",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return Center(
              child: Text(
                "Nenhuma promoção disponível",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final p = items[index];

              return Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    // FOTO DO PRODUTO
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

                          // PREÇO NORMAL (RISCADO)
                          Text(
                            "De: ${p["normal_price"]}",
                            style: TextStyle(
                              color: Colors.red.shade300,
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),

                          // PREÇO PROMO
                          Text(
                            "Por: ${p["promo_price"]}",
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 6),

                          // LOJA
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
          );
        },
      ),
    );
  }
}
