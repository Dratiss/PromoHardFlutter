import 'package:flutter/material.dart';
import '../services/promo_service.dart';
import '../widgets/promocard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PromoService promoService = PromoService();
  late Future<List<dynamic>> promotions;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    promotions = promoService.fetchPromotions();
  }

  List<dynamic> filterPromotions(List<dynamic> items) {
    if (searchQuery.isEmpty) return items;

    final query = searchQuery.toLowerCase();

    return items.where((promo) {
      final title = promo["title"].toString().toLowerCase();
      final store = promo["store"].toString().toLowerCase();
      final category = promo["category"].toString().toLowerCase();

      return title.contains(query) ||
          store.contains(query) ||
          category.contains(query);
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
          "PROMOHARD",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.35),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.12),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() => searchQuery = value);
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Buscar produto, loja ou categoria...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: promotions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.purpleAccent),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Erro ao carregar promoções",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhuma promoção encontrada",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final filteredItems = filterPromotions(snapshot.data!);

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 6),
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
          ),
        ],
      ),
    );
  }
}
