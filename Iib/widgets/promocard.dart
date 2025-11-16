import 'package:flutter/material.dart';
import 'dart:math';

class PromoCard extends StatelessWidget {
  final String title;
  final String normalPrice;
  final String promoPrice;
  final String imageUrl;
  final String store;
  final String expiresAt;
  final int? stock;
  final VoidCallback? onTap;

  PromoCard({
    required this.title,
    required this.normalPrice,
    required this.promoPrice,
    required this.imageUrl,
    required this.store,
    required this.expiresAt,
    this.stock,
    this.onTap,
  });

  // --- Cálculo de expiração ---
  String getExpirationText() {
    try {
      final exp = DateTime.parse(expiresAt);
      final now = DateTime.now();

      if (exp.isBefore(now)) return "EXPIRADO";

      final diff = exp.difference(now).inHours;
      if (diff <= 24) return "Oferta por tempo limitado";

      return "Expira em ${exp.day}/${exp.month}";
    } catch (e) {
      return "Expiração desconhecida";
    }
  }

  @override
  Widget build(BuildContext context) {
    final expiration = getExpirationText();
    final isExpired = expiration == "EXPIRADO";

    return Opacity(
      opacity: isExpired ? 0.45 : 1.0, // Deixa expirados apagados
      child: InkWell(
        onTap: isExpired ? null : onTap, // evita clicar se expirado
        borderRadius: BorderRadius.circular(12),

        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
          ),

          child: Row(
            children: [
              // ----------- IMAGEM DO PRODUTO -----------
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,

                  // Fallback para imagem quebrada (DartPad)
                  errorBuilder: (_, __, ___) => Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey.shade900,
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.white24,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12),

              // ----------- TEXTOS -----------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome
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

                    // Preço normal riscado
                    Text(
                      normalPrice,
                      style: TextStyle(
                        color: Colors.redAccent,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                      ),
                    ),

                    // Preço promocional
                    Text(
                      "Por: $promoPrice",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    // Loja
                    Text(
                      store,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 13,
                      ),
                    ),

                    SizedBox(height: 4),

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
                        style: TextStyle(
                          color: Colors.redAccent,
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
