import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final String title;
  final String normalPrice;
  final String promoPrice;
  final String imageUrl;
  final String store;
  final String? expiresAt;
  final int? stock;
  final VoidCallback onTap;

  const PromoCard({
    required this.title,
    required this.normalPrice,
    required this.promoPrice,
    required this.imageUrl,
    required this.store,
    required this.expiresAt,
    required this.stock,
    required this.onTap,
  });

  String getTimeRemaining(DateTime? expires) {
    if (expires == null) return "Tempo limitado";

    final diff = expires.difference(DateTime.now());

    if (diff.isNegative) return "EXPIRADO";

    if (diff.inMinutes < 60) {
      return "Acaba em ${diff.inMinutes} min";
    } else if (diff.inHours < 24) {
      return "Acaba em ${diff.inHours}h";
    } else {
      return "Acaba em ${diff.inDays} dias";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? expires =
        expiresAt != null ? DateTime.tryParse(expiresAt!) : null;

    String timeText = getTimeRemaining(expires);
    bool expired = timeText == "EXPIRADO";

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: expired ? 0.45 : 1.0,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 6),

                    // Preços
                    Text(
                      normalPrice,
                      style: TextStyle(
                        color: Colors.redAccent,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      promoPrice,
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 4),

                    // Loja
                    Text(
                      store,
                      style: TextStyle(color: Colors.blueAccent),
                    ),

                    SizedBox(height: 4),

                    // Prazo ou estoque
                    if (expired)
                      Text(
                        "EXPIRADO",
                        style: TextStyle(color: Colors.red, fontSize: 13),
                      )
                    else if (stock != null && stock! <= 5)
                      Text(
                        "🔥 Últimas $stock unidades",
                        style:
                            TextStyle(color: Colors.orangeAccent, fontSize: 13),
                      )
                    else
                      Text(
                        timeText,
                        style:
                            TextStyle(color: Colors.purpleAccent, fontSize: 13),
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
