import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String normalPrice;
  final String promoPrice;
  final String store;
  final String category;
  final String expiresAt;
  final int? stock;
  final VoidCallback onTap;

  const PromoCard({
    required this.imageUrl,
    required this.title,
    required this.normalPrice,
    required this.promoPrice,
    required this.store,
    required this.category,
    required this.expiresAt,
    required this.stock,
    required this.onTap,
  });

  // Transforma a data em texto
  String getExpirationText() {
    try {
      final date = DateTime.parse(expiresAt);
      final now = DateTime.now();
      final difference = date.difference(now);

      if (difference.isNegative) return "EXPIRADO";
      if (difference.inHours < 24) return "Expira em ${difference.inHours}h";
      return "Expira em ${difference.inDays} dias";
    } catch (e) {
      return "Validade desconhecida";
    }
  }

  @override
  Widget build(BuildContext context) {
    final expiration = getExpirationText();
    final isExpired = expiration == "EXPIRADO";

    return Opacity(
      opacity: isExpired ? 0.45 : 1.0,
      child: GestureDetector(
        onTap: isExpired ? () {} : onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withOpacity(0.04),
              width: 1,
            ),
          ),

          child: Row(
            children: [
              // Imagem com glow roxo suave
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.25),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    width: 76,
                    height: 76,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 76,
                      height: 76,
                      color: Colors.grey.shade800,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white30,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // Texto da promoção
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Preço original riscado
                    Text(
                      normalPrice,
                      style: TextStyle(
                        color: Colors.redAccent.withOpacity(0.85),
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                      ),
                    ),

                    // Preço promocional
                    Text(
                      "Por: $promoPrice",
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Loja
                    Text(
                      store,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Expiração
                    Text(
                      expiration,
                      style: TextStyle(
                        color:
                            isExpired ? Colors.redAccent : Colors.orangeAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Estoque baixo
                    if (stock != null && stock! <= 10 && !isExpired)
                      Text(
                        "🔥 Últimas $stock unidades!",
                        style: const TextStyle(
                          color: Colors.red,
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
