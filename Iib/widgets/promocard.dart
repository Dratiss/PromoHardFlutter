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

  // ============================================================
  // CALCULA TEMPO RESTANTE / EXPIRADO
  // ============================================================
  String getExpirationText() {
    if (expiresAt == null) return "Sem data";

    DateTime? date = DateTime.tryParse(expiresAt!);
    if (date == null) return "Sem data";

    final now = DateTime.now();

    if (date.isBefore(now)) return "EXPIRADO";

    final diff = date.difference(now);

    if (diff.inDays > 0) return "Expira em ${diff.inDays} dias";
    if (diff.inHours > 0) return "Expira em ${diff.inHours} horas";
    if (diff.inMinutes > 0) return "Expira em ${diff.inMinutes} min";

    return "Expira em instantes";
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
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey.shade800,
                    alignment: Alignment.center,
                    child: Icon(Icons.image_not_supported, color: Colors.white30),
                  ),
                ),
              ),

              SizedBox(width: 12),

              // INFORMAÇÕES
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TÍTULO
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

                    // PREÇO NORMAL
                    Text(
                      normalPrice,
                      style: TextStyle(
                        color: Colors.redAccent,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                      ),
                    ),

                    // PREÇO PROMOÇÃO
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
