import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/favorites_service.dart';

class PromoDetailsPage extends StatefulWidget {
  final Map<String, dynamic> promo;

  const PromoDetailsPage({super.key, required this.promo});

  @override
  State<PromoDetailsPage> createState() => _PromoDetailsPageState();
}

class _PromoDetailsPageState extends State<PromoDetailsPage> {
  Map<String, dynamic> get promo => widget.promo;

  void toggleFavorite() {
    setState(() {
      if (FavoritesService.isFavorite(promo["title"])) {
        FavoritesService.removeFavorite(promo);
      } else {
        FavoritesService.addFavorite(promo);
      }
    });
  }

  bool isExpired() {
    if (promo["expires_at"] == null) return false;
    final date = DateTime.tryParse(promo["expires_at"]);
    if (date == null) return false;
    return date.isBefore(DateTime.now());
  }

  String getExpirationText() {
    final expiresAt = promo["expires_at"];
    if (expiresAt == null || (expiresAt is String && expiresAt.isEmpty)) {
      return "Sem data";
    }

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
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        title: const Text("Detalhes da Promoção"),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              Share.share(
                "${promo['title']} está por ${promo['promo_price']}!\nLoja: ${promo['store']}\n${promo['link']}",
              );
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ===============================================
            // IMAGEM GRANDE
            // ===============================================
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                promo["image"] ?? "",
                height: 230,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 230,
                  color: Colors.grey[850],
                  child: const Icon(Icons.broken_image, color: Colors.white30, size: 40),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===============================================
            // TÍTULO
            // ===============================================
            Text(
              promo["title"] ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // ===============================================
            // CATEGORIA
            // ===============================================
            Text(
              "Categoria: ${promo['category'] ?? 'Diversos'}",
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),

            const SizedBox(height: 20),

            // ===============================================
            // PREÇOS
            // ===============================================
            Row(children: [
              Text(
                promo["normal_price"] ?? "",
                style: const TextStyle(
                  color: Colors.redAccent,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                promo["promo_price"] ?? "",
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),

            const SizedBox(height: 20),

            // ===============================================
            // LOJA
            // ===============================================
            Text(
              "Loja: ${promo['store']}",
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

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
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "🔥 Últimas ${promo["stock"]} unidades!",
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 25),

            // ===============================================
            // DESCRIÇÃO (placeholder)
            // ===============================================
            const Text(
              "Descrição",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              promo["description"] ??
                  "Promoção encontrada pelo sistema PromoHard. Visite o site da oferta para mais informações.",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 30),

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
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Ir para a oferta",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // ICONE FAVORITO (funcional)
                GestureDetector(
                  onTap: toggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      FavoritesService.isFavorite(promo["title"])
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: FavoritesService.isFavorite(promo["title"])
                          ? Colors.redAccent
                          : Colors.white,
                      size: 28,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
