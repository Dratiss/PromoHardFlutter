import 'package:flutter/material.dart';
import '../main.dart';
import '../services/promo_service.dart';
import '../widgets/promocard.dart';
import '../widgets/loading.dart';
import '../widgets/error_retry.dart';
import 'promo_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
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

  Future<void> _refresh() async {
    final novas = promoService.fetchPromotions();
    setState(() => promotions = novas);
    await novas;
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
      backgroundColor: const Color(0xFF0E0E0E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "PROMOHARD",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: AppColors.goldAccent.withOpacity(0.35),
                blurRadius: 12,
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          // BARRA DE BUSCA
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldAccent.withOpacity(0.18),
                    blurRadius: 14,
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
                  filled: true,
                  fillColor: const Color(0xFF1A1A1A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: promotions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }

                if (snapshot.hasError) {
                  return ErrorRetry(onRetry: _refresh);
                }

                final data = snapshot.data ?? [];
                final filteredItems = filterPromotions(data);

                if (filteredItems.isEmpty) {
                  return RefreshIndicator(
                    color: AppColors.goldAccent,
                    onRefresh: _refresh,
                    child: ListView(
                      children: const [
                        SizedBox(height: 200),
                        Center(
                          child: Text(
                            "Nenhuma promoção encontrada",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: AppColors.goldAccent,
                  onRefresh: _refresh,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PromoDetailsPage(
                                promo: Map<String, dynamic>.from(promo),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
