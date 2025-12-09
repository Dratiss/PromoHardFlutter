import 'package:flutter/material.dart';
import '../widgets/promocard.dart';
import '../services/promo_service.dart';

class CategoryProductsPage extends StatefulWidget {
  final String categoryName;

  const CategoryProductsPage({required this.categoryName});

  @override
  _CategoryProductsPageState createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final PromoService promoService = PromoService();
  late Future<List<dynamic>> promotions;

  @override
  void initState() {
    super.initState();
    promotions = promoService.fetchPromotions();
  }

  List<dynamic> filterByCategory(List<dynamic> items) {
    return items.where((promo) {
      return promo["category"].toString().toLowerCase() ==
          widget.categoryName.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E0E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.categoryName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.25),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),

      body: FutureBuilder<List<dynamic>>(
        future: promotions,
        builder: (context, snapshot) {
          // Carregando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purpleAccent,
              ),
            );
          }

          // Erro
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar promoções",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          final filteredItems = filterByCategory(snapshot.data ?? []);

          // Lista vazia
          if (filteredItems.isEmpty) {
            return Center(
              child: Text(
                "Nenhuma oferta encontrada",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              ),
            );
          }

          // Lista final
          return ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final promo = filteredItems[index];
              return PromoCard(
                title: promo["title"],
                normalPrice: promo["normal_price"],
                promoPrice: promo["promo_price"],
                imageUrl: promo["image"] ?? "",
                store: promo["store"],
                category: promo["category"],
                expiresAt: promo["expires_at"],
                stock: promo["stock"],
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
