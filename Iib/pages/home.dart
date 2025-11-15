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

  bool showExpired = true; // mostrar promoções expiradas
  String selectedGroup = "Tudo"; // grupo selecionado
  String selectedCategory = ""; // subcategoria selecionada
  String sortMode = "none"; // modo de ordenação

  // Mapa profissional de categorias por grupo
  final Map<String, List<String>> subcategories = {
    "Hardware": ["CPU", "GPU", "Placa-mãe", "RAM"],
    "Armazenamento": ["SSD", "HD"],
    "Energia": ["Fonte", "Gabinete", "Resfriamento"],
    "Periféricos": ["Mouse", "Teclado", "Headset", "Webcam", "Microfone", "Mousepad"],
    "Consoles": ["PlayStation", "Xbox", "Nintendo", "Acessórios"],
    "Notebooks": ["Notebooks"],
    "Diversos": ["Diversos"]
  };

  final List<String> groups = [
    "Tudo",
    "Hardware",
    "Armazenamento",
    "Energia",
    "Periféricos",
    "Consoles",
    "Notebooks",
    "Diversos"
  ];

  @override
  void initState() {
    super.initState();
    promotions = promoService.fetchPromotions();
  }

  // =============================================
  // ORDENAR LISTA
  // =============================================
  List<dynamic> applySorting(List<dynamic> items) {
    List<dynamic> sorted = List.from(items);

    if (sortMode == "discount") {
      sorted.sort((a, b) {
        double pa = _priceToDouble(a["promo_price"]);
        double na = _priceToDouble(a["normal_price"]);

        double pb = _priceToDouble(b["promo_price"]);
        double nb = _priceToDouble(b["normal_price"]);

        double discountA = na - pa;
        double discountB = nb - pb;

        return discountB.compareTo(discountA);
      });
    }

    if (sortMode == "low_price") {
      sorted.sort((a, b) =>
          _priceToDouble(a["promo_price"]).compareTo(_priceToDouble(b["promo_price"])));
    }

    if (sortMode == "time") {
      sorted.sort((a, b) {
        final da = a["expires_at_parsed"];
        final db = b["expires_at_parsed"];
        if (da == null || db == null) return 0;
        return da.compareTo(db);
      });
    }

    return sorted;
  }

  double _priceToDouble(String price) {
    return double.tryParse(price.replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(",", ".")) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Promoções em tempo real"),
        centerTitle: true,
        elevation: 0,

        actions: [
          // Mostrar ou ocultar expiradas
          Row(
            children: [
              Text("Expiradas",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              Switch(
                value: showExpired,
                activeColor: Colors.redAccent,
                onChanged: (value) {
                  setState(() {
                    showExpired = value;
                  });
                },
              ),
            ],
          ),

          // Menu de ordenação
          PopupMenuButton<String>(
            icon: Icon(Icons.sort, color: Colors.white),
            onSelected: (value) {
              setState(() {
                sortMode = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: "none", child: Text("Padrão")),
              PopupMenuItem(value: "discount", child: Text("Maior desconto")),
              PopupMenuItem(value: "low_price", child: Text("Menor preço")),
              PopupMenuItem(value: "time", child: Text("Tempo restante")),
            ],
          ),
        ],
      ),

      body: FutureBuilder<List<dynamic>>(
        future: promotions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.redAccent));
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar promoções",
                  style: TextStyle(color: Colors.white)),
            );
          }

          List items = snapshot.data ?? [];

          // =============================================
          // FILTRAR EXPIRADAS
          // =============================================
          final now = DateTime.now();
          List filtered = showExpired
              ? items
              : items.where((promo) =>
                  promo["expires_at_parsed"] != null &&
                  promo["expires_at_parsed"].isAfter(now)).toList();

          // =============================================
          // FILTRAR GRUPO
          // =============================================
          if (selectedGroup != "Tudo") {
            filtered = filtered.where((item) =>
                item["group"] == selectedGroup).toList();
          }

          // =============================================
          // FILTRAR SUBCATEGORIA
          // =============================================
          if (selectedCategory.isNotEmpty) {
            filtered = filtered.where((item) =>
                item["category"] == selectedCategory).toList();
          }

          // =============================================
          // ORDENAR
          // =============================================
          filtered = applySorting(filtered);

          return Column(
            children: [
              // ==================================================
              // BARRA DE GRUPOS
              // ==================================================
              Container(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  children: groups.map((g) {
                    bool active = selectedGroup == g;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(g),
                        selected: active,
                        onSelected: (_) {
                          setState(() {
                            selectedGroup = g;
                            selectedCategory = ""; // limpa subcat
                          });
                        },
                        selectedColor: Colors.redAccent,
                        backgroundColor: Colors.grey[800],
                        labelStyle: TextStyle(
                          color: active ? Colors.white : Colors.white70,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // ==================================================
              // BARRA DE SUBCATEGORIAS (MOSTRA SÓ QUANDO PRECISO)
              // ==================================================
              if (selectedGroup != "Tudo")
                Container(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    children: subcategories[selectedGroup]!.map((c) {
                      bool active = selectedCategory == c;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(c),
                          selected: active,
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = c;
                            });
                          },
                          selectedColor: Colors.blueAccent,
                          backgroundColor: Colors.grey[800],
                          labelStyle: TextStyle(
                            color: active ? Colors.white : Colors.white70,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

              // ==================================================
              // LISTA DE PROMOÇÕES
              // ==================================================
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          "Nenhuma promoção encontrada",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final promo = filtered[index];
                          return PromoCard(
                            title: promo["title"],
                            normalPrice: promo["normal_price"],
                            promoPrice: promo["promo_price"],
                            imageUrl: promo["image"],
                            store: promo["store"],
                            expiresAt: promo["expires_at"],
                            stock: promo["stock"],
                            onTap: () {},
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
