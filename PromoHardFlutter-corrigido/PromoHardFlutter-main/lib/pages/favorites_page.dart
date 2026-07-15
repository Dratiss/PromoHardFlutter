import 'package:flutter/material.dart';
import '../widgets/promocard.dart';
import '../services/favorites_service.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesService.favorites;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Favoritos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.35),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),

      body: favorites.isEmpty
          ? Center(
              child: Text(
                "Nenhuma promoção favoritada",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 17,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final promo = favorites[index];

                return Dismissible(
                  key: ValueKey(promo["title"]),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),

                  onDismissed: (_) {
                    FavoritesService.removeFavorite(promo);
                    setState(() {});
                  },

                  child: PromoCard(
                    title: promo["title"],
                    normalPrice: promo["normal_price"],
                    promoPrice: promo["promo_price"],
                    imageUrl: promo["image"] ?? "",
                    store: promo["store"],
                    category: promo["category"],
                    expiresAt: promo["expires_at"],
                    stock: promo["stock"],
                    onTap: () {},
                  ),
                );
              },
            ),
    );
  }
}
