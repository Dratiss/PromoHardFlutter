import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
    if (diff.inHours < 1) return "Expira em ${diff.inMinutes} minutos";
    if (diff.inHours < 24) return "Expira em ${diff.inHours} horas";

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
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
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

            // ===============================================
            // IMAGEM GRANDE
            // ===============================================
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                promo["image"],
                height: 230,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 230,
                  color: Colors.grey[850],
                  child: Icon(Icons.broken_image, color: Colors.white30, size: 40),
                ),
              ),
            ),

            SizedBox(height: 20),

            // ===============================================
            // TÍTULO
            // ===============================================
            Text(
              promo["title"],
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            // ===============================================
            // CATEGORIA
            // ===============================================
            Text(
              "Categoria: ${promo['category']}",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),

            SizedBox(height: 20),

            // ===============================================
            // PREÇOS
            // ===============================================
            Row(children: [
              Text(
                promo["normal_price"],
                style: TextStyle(
                  color: Colors.redAccent,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 12),
              Text(
                promo["promo_price"],
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),

            SizedBox(height: 20),

            // ===============================================
            // LOJA
            // ===============================================
            Text(
              "Loja: ${promo['store']}",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 12),

            // ===============================================
            // EXPIRAÇÃO
            // ===============================================
            Text(
              getExpirationText(),
              style: TextStyle(
                color: expired ? Colors.redAccent : Colors.orangeAccent,
                fontSize: 16,
              ),
            ),

            if (promo["stock"] != null && promo["stock"] <= 10 && !expired)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "🔥 Últimas ${promo["stock"]} unidades!",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            SizedBox(height: 25),

            // ===============================================
            // DESCRIÇÃO (placeholder)
            // ===============================================
            Text(
              "Descrição",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 6),

            Text(
              promo["description"] ??
                  "Promoção encontrada pelo sistema PromoHard. Visite o site da oferta para mais informações.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.4,
              ),
            ),

            SizedBox(height: 30),

            // ===============================================
            // BOTÕES
            // ===============================================
            Row(
              children: [
                // BOTÃO IR PARA OFERTA
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (promo["link"] == null) return;

                      final uri = Uri.parse(promo["link"]);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Ir para a oferta",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(width: 16),

                // ICONE FAVORITO (futuro)
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.favorite_border, color: Colors.white, size: 28),
                )
              ],
            ),

            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
