import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoDetailsPage extends StatelessWidget {
  final Map<String, dynamic> promo;

  const PromoDetailsPage({required this.promo});

  double _priceToDouble(String price) {
    return double.tryParse(price.replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(",", ".")) ?? 0;
  }

  String getExpirationText(String? expiresAt) {
    if (expiresAt == null) return "Sem validade";

    DateTime? date = DateTime.tryParse(expiresAt);
    if (date == null) return "Sem validade";

    final now = DateTime.now();
    if (date.isBefore(now)) return "Oferta expirada";

    final diff = date.difference(now);

    if (diff.inDays > 0) return "Expira em ${diff.inDays} dias";
    if (diff.inHours > 0) return "Expira em ${diff.inHours} horas";
    if (diff.inMinutes > 0) return "Expira em ${diff.inMinutes} minutos";

    return "Expira em instantes";
  }

  @override
  Widget build(BuildContext context) {
    final String title = promo["title"];
    final String normalPrice = promo["normal_price"];
    final String promoPrice = promo["promo_price"];
    final String store = promo["store"];
    final String? expiresAt = promo["expires_at"];
    final int? stock = promo["stock"];
    final String url = promo["link"] ?? "https://www.google.com"; // Placeholder caso não tenha link

    // calcula porcentagem de desconto
    final double np = _priceToDouble(normalPrice);
    final double pp = _priceToDouble(promoPrice);
    final int discount = (100 - ((pp / np) * 100)).round();

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Detalhes da promoção"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGEM PRINCIPAL
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                promo["image"],
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 240,
                  color: Colors.grey.shade800,
                  child: Icon(Icons.broken_image, color: Colors.white30, size: 50),
                ),
              ),
            ),

            SizedBox(height: 20),

            // TÍTULO
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            // PREÇOS
            Row(
              children: [
                Text(
                  normalPrice,
                  style: TextStyle(
                    color: Colors.redAccent,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  promoPrice,
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "-$discount%",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // LOJA
            Text(
              "Loja: $store",
              style: TextStyle(color: Colors.blueAccent, fontSize: 16),
            ),

            SizedBox(height: 10),

            // EXPIRAÇÃO
            Text(
              getExpirationText(expiresAt),
              style: TextStyle(
                color: expiresAt != null &&
                        DateTime.tryParse(expiresAt)!.isBefore(DateTime.now())
                    ? Colors.redAccent
                    : Colors.orangeAccent,
                fontSize: 15,
              ),
            ),

            if (stock != null && stock! <= 10)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  "🔥 Últimas $stock unidades!",
                  style: TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              ),

            SizedBox(height: 25),

            // DESCRIÇÃO
            Text(
              "Descrição",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              promo["description"] ??
                  "Promoção encontrada automaticamente pelo sistema PromoHard.",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),

            SizedBox(height: 30),

            // BOTÃO "IR PARA A OFERTA"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final Uri finalUrl = Uri.parse(url);
                  if (await canLaunchUrl(finalUrl)) {
                    await launchUrl(finalUrl, mode: LaunchMode.externalApplication);
                  }
                },
                child: Text(
                  "Ir para a oferta",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
