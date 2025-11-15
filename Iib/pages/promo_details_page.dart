import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class PromoDetailsPage extends StatelessWidget {
  final Map<String, dynamic> promo;

  PromoDetailsPage({required this.promo});

  bool isExpired() {
    if (promo["expires_at"] == null) return false;
    final date = DateTime.tryParse(promo["expires_at"]);
    if (date == null) return false;
    return date.isBefore(DateTime.now());
  }

  String getExpirationText() {
    final expiresAt = promo["expires_at"];
    if (expiresAt == null || expiresAt.isEmpty) return "Sem data";

    final expiryDate = DateTime.tryParse(expiresAt);
    if (expiryDate == null) return "Sem data";

    final now = DateTime.now();

    if (expiryDate.isBefore(now)) return "Expirado";

    final diff = expiryDate.difference(now);
    if (diff.inHours < 24) return "Expira em ${diff.inHours}h";

    return "Expira em ${diff.inDays} dias";
  }

  @override
  Widget build(BuildContext context) {
    final expired = isExpired();

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("Detalhes da Promoção"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                "${promo['title']} está por ${promo['promo_price']}!\nLoja: ${promo['store']}\n${promo['link']}",
              );
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGEM GRANDE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                promo["image"],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: Colors.grey[800],
                  child: Icon(Icons.image_not_supported, color: Colors.white38, size: 40),
                ),
              ),
            ),

            SizedBox(height: 15),

            // TÍTULO
            Text(
              promo["title"],
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            // CATEGORIA
            Text(
              "Categoria: ${promo['category']}",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),

            SizedBox(height: 15),

            // PREÇOS
            Row(
              children: [
                Text(
                  promo["normal_price"],
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "Por ${promo['promo_price']}",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // LOJA
            Text(
              promo["store"],
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 15),

            // EXPIRAÇÃO
            Text(
              getExpirationText(),
              style: TextStyle(
                color: expired ? Colors.redAccent : Colors.orangeAccent,
                fontSize: 15,
              ),
            ),

            if (promo["stock"] != null && promo["stock"] <= 10 && !expired)
              Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  "🔥 Últimas ${promo['stock']} unidades!",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            SizedBox(height: 25),

            // BOTÕES
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // abrir link no futuro
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Ir para oferta",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 12),

                // ❤️ FAVORITO FUTURO
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
