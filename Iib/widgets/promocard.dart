@override
  Widget build(BuildContext context) {
    final expiration = getExpirationText();
    final isExpired = expiration == "EXPIRADO";

    return Opacity(
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
    );
  }
