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
  bool showOnlyActive = true; // <<< Filtro padrão

  @override
  void initState() {
    super.initState();
    promotions = promoService.fetchPromotions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        title: const Text("Promoções"),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),

      body: Column(
        children: [
          const SizedBox(height: 8),

          // 🔥 SEGMENTED CONTROL (ATIVAS | TODAS)
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSegmentButton("Ativas", true),
                const SizedBox(width: 8),
                _buildSegmentButton("Todas", false),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // 🔥 LISTA DE PROMOÇÕES
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: promotions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.redAccent),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Erro ao carregar promoções",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhuma promoção encontrada",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }

                final allItems = snapshot.data!;
                final filteredItems = showOnlyActive
                    ? allItems.where((promo) {
                        final exp = promo["expires_at_parsed"];
                        return exp == null || exp.isAfter(DateTime.now());
                      }).toList()
                    : allItems;

                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final promo = filteredItems[index];

                    return PromoCard(
                      title: promo["title"],
                      normalPrice: promo["normal_price"],
                      promoPrice: promo["promo_price"],
                      imageUrl: promo["image"],
                      store: promo["store"],
                      expiresAt: promo["expires_at"],
                      stock: promo["stock"],
                      onTap: () {
                        // Futuro: abrir detalhes
                      },
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

  // 🔥 BOTÃO DE SEGMENTO (ATIVAS | TODAS)
  Widget _buildSegmentButton(String text, bool value) {
    final bool isSelected = (showOnlyActive == value);

    return GestureDetector(
      onTap: () {
        setState(() {
          showOnlyActive = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.redAccent : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.redAccent : Colors.grey.shade700,
            width: 1.4,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade400,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
