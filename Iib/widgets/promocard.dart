import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String normalPrice;
  final String promoPrice;
  final String store;
  final String? expiresAt;
  final int? stock;
  final VoidCallback onTap;

  PromoCard({
    required this.imageUrl,
    required this.title,
    required this.normalPrice,
    required this.promoPrice,
    required this.store,
    required this.expiresAt,
    required this.stock,
    required this.onTap,
  });

  // Calcula texto da expiração
  String getExpirationText() {
    if (expiresAt == null || expiresAt!.isEmpty) {
      return "Oferta por tempo limitado";
    }

    final endTime = DateTime.tryParse(expiresAt!);
    if (endTime == null) return "Oferta por tempo limitado";

    final now = DateTime.now();

    if (now.isAfter(endTime)) return "EXPIRADO";

    final diff = endTime.difference(now);

    if (diff.inMinutes < 60) return "Acaba em ${diff.inMinutes} min";
    if (diff.inHours < 24) return "Acaba em ${diff.inHours}h";
    return "Acaba em ${diff.inDays} dias";
  }

  @override
  Widget build(BuildContext context) {
    final expiration = getExpirationText();
    final isExpired = expiration == "EXPIRADO";

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isExpired ? 0.45 : 1.0, // <<< deixa o card apagado
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
          ),

          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey.shade800,
                    child: Icon(Icons.image_not_supported, color: Colors.white30),
                  ),
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      normalPrice,
                      style: TextStyle(
                        color: Colors.redAccent,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      "Por: $promoPrice",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      store,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 13,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      expiration,
                      style: TextStyle(
                        color: isExpired ? Colors.redAccent : Colors.orangeAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    if (stock != null && stock! <= 10 && !isExpired)
                      Text(
                        "🔥 Últimas $stock unidades!",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
