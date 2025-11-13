import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String promoPrice;
  final VoidCallback onTap;

  const PromoCard({
    required this.imageUrl,
    required this.title,
    required this.promoPrice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGEM
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 8),

            // TÍTULO
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),

            SizedBox(height: 6),

            // PREÇO PROMOCIONAL
            Text(
              promoPrice,
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
