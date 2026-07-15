import 'package:flutter/material.dart';
import '../services/favorites_service.dart';

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
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF151515),
          borderRadius: BorderRadius.circular(16),

          // GLOW ROXO SUAVE
          boxShadow: [
            BoxShadow(
              color: Colors.purpleAccent.withOpacity(0.15),
              blurRadius: 12,
              spreadRadius: 2,
              offset: Offset(0, 4),
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
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 12),

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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            if (isFavorite) {
                              FavoritesService.removeFavorite({
                                "title": title,
                                "normal_price": normalPrice,
                                "promo_price": promoPrice,
                                "store": store,
                                "image": imageUrl,
                                "expires_at": expiresAt,
                                "stock": stock,
                              });
                            } else {
                              FavoritesService.addFavorite({
                                "title": title,
                                "normal_price": normalPrice,
                                "promo_price": promoPrice,
                                "store": store,
                                "image": imageUrl,
                                "expires_at": expiresAt,
                                "stock": stock,
                              });
                            }
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.redAccent : Colors.white54,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6),

                    Text(
                      normalPrice,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

                    Text(
                      "Por: $promoPrice",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      store,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 13),
                    ),

                    SizedBox(height: 4),

                    Text(
                      expiration,
                      style: TextStyle(
                        color:
                            isExpired ? Colors.redAccent : Colors.orangeAccent,
                        fontSize: 12,
                      ),
                    ),

                    if (stock != null && stock! <= 10 && !isExpired)
                      Text(
                        "🔥 Últimas $stock unidades!",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12,
                        ),
                      ),
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
