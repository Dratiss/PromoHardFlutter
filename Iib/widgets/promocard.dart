import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final String title;
  final String normalPrice;
  final String promoPrice;
  final String imageUrl;
  final String store;
  final String expiresAt;
  final int? stock;
  final String category;
  final VoidCallback onTap;

  PromoCard({
    required this.title,
    required this.normalPrice,
    required this.promoPrice,
    required this.imageUrl,
    required this.store,
    required this.expiresAt,
    required this.stock,
    required this.category,
    required this.onTap,
  });

  String getExpirationText() {
    if (expiresAt.isEmpty) return "SEM DATA";

    final expiryDate = DateTime.tryParse(expiresAt);
    if (expiryDate == null) return "SEM DATA";

    final now = DateTime.now();

    if (expiryDate.isBefore(now)) {
      return "EXPIRADO";
    }

    final diff = expiryDate.difference(now);
    if (diff.inHours < 24) {
      return "Expira em ${diff.inHours}h";
    }

    return "Expira em ${diff.inDays} dias";
  }

  @override
  Widget build(BuildContext context) {
    final expiration = getExpirationText();
    final isExpired = expiration == "EXPIRADO";

    return Opacity(
      opacity: isExpired ? 0.40 : 1.0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
          ),

          child: Row(
            children: [
              // IMAGEM
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 75,
                    height: 75,
                    color: Colors.grey.shade800,
                    child: Icon(Icons.image_not_supported, color: Colors.white30),
                  ),
                ),
              ),

              SizedBox(width: 12),

              // TEXTOS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
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

                    // PREÇO ANTIGO
                    Text(
                      normalPrice,
                      style: TextStyle(
                        color: Colors.redAccent,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                      ),
                    ),

                    // PREÇO PROMO
                    Text(
                      "Por: $promoPrice",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    // LOJA
                    Text(
                      store,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 13,
                      ),
                    ),

                    SizedBox(height: 4),

                    // EXPIRAÇÃO
                    Text(
                      expiration,
                      style: TextStyle(
                        color: isExpired ? Colors.redAccent : Colors.orangeAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // ESTOQUE BAIXO
                    if (stock != null && stock! <= 10 && !isExpired)
                      Text(
                        "🔥 Últimas $stock unidades!",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),

                    // CATEGORIA
                    SizedBox(height: 4),
                    Text(
                      "Categoria: $category",
                      style: TextStyle(color: Colors.white54, fontSize: 11),
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
