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
      backgroundColor: Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: Color(0xFF0E0E0E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Favoritos",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.20),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),

      body: favorites.isEmpty
          ? Center(
              child: Text(
                "Nenhuma promoção favoritada",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final promo = favorites[index];

                return Dismissible(
                  key: ValueKey(promo["title"]),
                  background: Container(
                    color: Colors.redAccent.withOpacity(0.4),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
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
