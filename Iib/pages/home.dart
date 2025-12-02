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

  // Função de filtro completo (título + loja + categoria)
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
      backgroundColor: Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: Color(0xFF0E0E0E),
        elevation: 0,
        centerTitle: true,

        // PROMOHARD centralizado com micro glow roxo
        title: Text(
          "PROMOHARD",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.purpleAccent.withOpacity(0.25),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          // Barra de busca
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: TextField(
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Buscar produto, loja ou categoria...",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Color(0xFF1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: promotions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.redAccent),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar promoções",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "Nenhuma promoção encontrada",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final filteredItems =
                    filterPromotions(snapshot.data!);

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
          ),
        ],
      ),
    );
  }
}
