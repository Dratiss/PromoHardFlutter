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

  bool isSearching = false;
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();

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
        backgroundColor: Colors.black,
        centerTitle: true,

        // ===================================================
        // APPBAR DINÂMICO — TÍTULO OU CAMPO DE BUSCA
        // ===================================================
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.redAccent,
                decoration: InputDecoration(
                  hintText: "Buscar promoção...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() => searchQuery = value.toLowerCase());
                },
              )
            : Text("Promoções em tempo real"),

        actions: [
          // ÍCONE DE BUSCA
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  searchQuery = "";
                }
                isSearching = !isSearching;
              });
            },
          ),

          // FILTRO NO MENU
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onSelected: (value) {
              setState(() => filterStatus = value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: "Ativas", child: Text("Somente Ativas")),
              PopupMenuItem(value: "Expiradas", child: Text("Somente Expiradas")),
              PopupMenuItem(value: "Todas", child: Text("Todas")),
            ],
          ),
        ],
      ),

      // ===================================================
      // CONTEÚDO PRINCIPAL
      // ===================================================
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
              child: Text("Erro ao carregar promoções",
                  style: TextStyle(color: Colors.white)),
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

          // FILTRO POR BUSCA
          if (searchQuery.isNotEmpty) {
            items = items.where((p) {
              return p["title"].toLowerCase().contains(searchQuery) ||
                  p["category"].toLowerCase().contains(searchQuery);
            }).toList();
          }

          return Column(
            children: [
              // ===================================================
              // SCROLL DE CATEGORIAS
              // ===================================================
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 12),
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

              // ===================================================
              // LISTA DE PROMOÇÕES CARD
              // ===================================================
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
}
