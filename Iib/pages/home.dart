import 'package:flutter/material.dart';
import '../services/promo_service.dart';
import '../widgets/promocard.dart';
import 'promo_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PromoService promoService = PromoService();
  late Future<List<dynamic>> promotions;

  String selectedCategory = "Todas";
  String filterStatus = "Ativas"; // Ativas / Expiradas / Todas

  @override
  void initState() {
    super.initState();
    promotions = promoService.fetchPromotions();
  }

  List<String> categories = [
    "Todas",
    "Processadores",
    "Placas de Vídeo",
    "Armazenamento",
    "Periféricos",
    "Consoles",
    "Cadeiras",
    "Outros",
  ];

  bool isExpired(String? expiresAt) {
    if (expiresAt == null) return false;
    final date = DateTime.tryParse(expiresAt);
    if (date == null) return false;
    return date.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("Promoções em tempo real"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),

      body: FutureBuilder<List<dynamic>>(
        future: promotions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar promoções", style: TextStyle(color: Colors.white)),
            );
          }

          var items = snapshot.data ?? [];

          // FILTRO POR CATEGORIA
          if (selectedCategory != "Todas") {
            items = items.where((p) => p["category"] == selectedCategory).toList();
          }

          // FILTRO POR STATUS
          if (filterStatus == "Ativas") {
            items = items.where((p) => !isExpired(p["expires_at"])).toList();
          } else if (filterStatus == "Expiradas") {
            items = items.where((p) => isExpired(p["expires_at"])).toList();
          }

          return Column(
            children: [
              // SELETOR DE STATUS
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statusButton("Ativas"),
                    _statusButton("Expiradas"),
                    _statusButton("Todas"),
                  ],
                ),
              ),

              // SELETOR DE CATEGORIA
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: categories.map((c) {
                    final selected = c == selectedCategory;
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = c),
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected ? Colors.redAccent : Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            c,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final promo = items[index];

                    return PromoCard(
                      title: promo["title"],
                      normalPrice: promo["normal_price"],
                      promoPrice: promo["promo_price"],
                      imageUrl: promo["image"],
                      store: promo["store"],
                      expiresAt: promo["expires_at"],
                      stock: promo["stock"],
                      category: promo["category"],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PromoDetailsPage(promo: promo),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _statusButton(String text) {
    final selected = filterStatus == text;
    return GestureDetector(
      onTap: () => setState(() => filterStatus = text),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.redAccent : Colors.white70,
          fontSize: selected ? 18 : 15,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
