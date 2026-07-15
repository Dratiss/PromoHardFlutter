import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../main.dart'; // Importando AppColors

class PromoCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String normalPrice;
  final String promoPrice;
  final String store;
  final String? expiresAt;
  final int? stock;
  final VoidCallback onTap;

  const PromoCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.normalPrice,
    required this.promoPrice,
    required this.store,
    required this.expiresAt,
    required this.stock,
    required this.onTap,
  });

  @override
  State<PromoCard> createState() => _PromoCardState();
}

class _PromoCardState extends State<PromoCard> {
  String getExpirationText() {
    if (widget.expiresAt == null) return "Sem prazo definido";
    final parsed = DateTime.tryParse(widget.expiresAt!);
    if (parsed == null) return "Sem prazo definido";
    final now = DateTime.now();
    final diff = parsed.difference(now).inHours;
    if (diff <= 0) return "EXPIRADO";
    if (diff < 24) return "Termina em $diff horas";
    return "Termina em ${parsed.day}/${parsed.month}";
  }

  Map<String, dynamic> promoAsMap() {
    return {
      "title": widget.title,
      "normal_price": widget.normalPrice,
      "promo_price": widget.promoPrice,
      "image": widget.imageUrl,
      "store": widget.store,
      "expires_at": widget.expiresAt,
      "stock": widget.stock,
    };
  }

  void toggleFavorite() {
    setState(() {
      if (FavoritesService.isFavorite(widget.title)) {
        FavoritesService.removeFavorite(promoAsMap());
      } else {
        FavoritesService.addFavorite(promoAsMap());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = FavoritesService.isFavorite(widget.title);
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
          onTap: widget.onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[850],
                    child: const Icon(Icons.broken_image,
                        color: Colors.white30, size: 28),
                  ),
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
                            widget.title,
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
                          onTap: toggleFavorite,
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.redAccent : Colors.white54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.normalPrice,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough, // Preço riscado
                      ),
                    ),
                    Text(
                      "Por: ${widget.promoPrice}",
                      style: const TextStyle(
                        color: AppColors.promoGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold, // Preço promo maior e verde
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.store,
                      style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 13), // Nome da loja em azul
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          expiration,
                          style: TextStyle(
                            color:
                                isExpired ? Colors.redAccent : Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        if (widget.stock != null &&
                            widget.stock! <= 10 &&
                            !isExpired)
                          Text(
                            "🔥 Últimas ${widget.stock} und!",
                            style: const TextStyle(
                              color: Colors.redAccent,
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
