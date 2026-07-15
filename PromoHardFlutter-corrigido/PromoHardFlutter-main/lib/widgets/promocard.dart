import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../main.dart'; // Importando AppColors

class PromoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String normalPrice;
  final String promoPrice;
  final String store;
  final String? expiresAt;
  final int? stock;
  final VoidCallback onTap;

  const PromoCard({
    required this.imageUrl,
    required this.title,
    required this.normalPrice,
    required this.promoPrice,
    required this.store,
    required this.expiresAt,
    required this.stock,
    required this.onTap,
  });

  String getExpirationText() {
    if (expiresAt == null) return "Sem prazo definido";
    final parsed = DateTime.tryParse(expiresAt!);
    if (parsed == null) return "Sem prazo definido";
    final now = DateTime.now();
    final diff = parsed.difference(now).inHours;
    if (diff <= 0) return "EXPIRADO";
    if (diff < 24) return "Termina em $diff horas";
    return "Termina em ${parsed.day}/${parsed.month}";
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = FavoritesService.isFavorite(title);
    final expiration = getExpirationText();
    final isExpired = expiration == "EXPIRADO";

    return Opacity(
      opacity: isExpired ? 0.45 : 1.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card, // Fundo #151515
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.goldAccent.withOpacity(0.12), // Glow Dourado sutil
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (isFavorite) {
                              FavoritesService.removeFavorite({"title": title});
                            } else {
                              FavoritesService.addFavorite({"title": title});
                            }
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? AppColors.redAccent : Colors.white54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      normalPrice,
                      style: const TextStyle(
                        color: AppColors.redAccent,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough, // Preço riscado
                      ),
                    ),
                    Text(
                      "Por: $promoPrice",
                      style: const TextStyle(
                        color: AppColors.promoGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold, // Preço promo maior e verde
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      store,
                      style: const TextStyle(color: AppColors.blueAccent, fontSize: 13), // Nome da loja em azul
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          expiration,
                          style: TextStyle(
                            color: isExpired ? AppColors.redAccent : Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        if (stock != null && stock! <= 10 && !isExpired)
                          Text(
                            "🔥 Últimas $stock und!",
                            style: const TextStyle(
                              color: AppColors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}