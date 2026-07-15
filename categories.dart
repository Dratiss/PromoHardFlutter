import 'package:flutter/material.dart';
import '../widgets/promocard.dart';
import '../widgets/loading.dart';
import '../services/promo_service.dart';

class CategoryProductsPage extends StatefulWidget {
  final String categoryName;

  const CategoryProductsPage({super.key, required this.categoryName});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
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
      backgroundColor: const Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E0E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.categoryName,
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

      body: FutureBuilder<List<dynamic>>(
        future: promotions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Erro ao carregar promoções",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final filteredItems = filterByCategory(snapshot.data ?? []);

          if (filteredItems.isEmpty) {
            return const Center(
              child: Text(
                "Nenhuma oferta encontrada nessa categoria",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

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
