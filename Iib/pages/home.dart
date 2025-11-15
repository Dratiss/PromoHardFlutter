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
  String sortMode = "none"; // modo de ordenação

  @override
  void initState() {
    super.initState();
    promotions = promoService.fetchPromotions();
  }

  // ==================================================
  // FUNÇÃO DE ORDENAR
  // ==================================================
  List<dynamic> applySorting(List<dynamic> items) {
    List<dynamic> sorted = List.from(items);

    if (sortMode == "discount") {
      sorted.sort((a, b) {
        double pa = double.tryParse(a["promo_price"].replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(",", ".")) ?? 0;
        double na = double.tryParse(a["normal_price"].replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(",", ".")) ?? 0;

        double pb = double.tryParse(b["promo_price"].replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(",", ".")) ?? 0;
        double nb = double.tryParse(b["normal_price"].replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(",", ".")) ?? 0;

        double discountA = na - pa;
        double discountB = nb - pb;
        return discountB.compareTo(discountA); // MAIOR DESCONTO PRIMEIRO
      });
    }

    if (sortMode == "low_price") {
      sorted.sort((a, b) {
        double pa = double.tryParse(a["promo_price"].replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(",", ".")) ?? 0;
        double pb = double.tryParse(b["promo_price"].replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(",", ".")) ?? 0;
        return pa.compareTo(pb); // MENOR PREÇO PRIMEIRO
      });
    }

    if (sortMode == "time") {
      sorted.sort((a, b) {
        final da = a["expires_at_parsed"];
        final db = b["expires_at_parsed"];
        if (da == null || db == null) return 0;
        return da.compareTo(db); // MENOR TEMPO RESTANTE
      });
    }

    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),

      // ==================================================
      // APP BAR COM FILTRO E ORDENAÇÃO
      // ==================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Promoções em tempo real"),
        centerTitle: true,
        elevation: 0,

        actions: [
          // Switch para mostrar expiradas
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
              PopupMenuItem(
                value: "none",
                child: Text("Padrão"),
              ),
              PopupMenuItem(
                value: "discount",
                child: Text("Maior desconto"),
              ),
              PopupMenuItem(
                value: "low_price",
                child: Text("Menor preço"),
              ),
              PopupMenuItem(
                value: "time",
                child: Text("Tempo restante"),
              ),
            ],
          ),
        ],
      ),

      // ==================================================
      // LISTA DE PROMOÇÕES
      // ==================================================
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
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Nenhuma promoção encontrada",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            );
          }

          // Lista original
          List items = snapshot.data!;

          // 1. Filtrar expiradas
          final filteredItems = showExpired
              ? items
              : items.where((promo) {
                  final expiry = promo["expires_at_parsed"];
                  return expiry != null && expiry.isAfter(DateTime.now());
                }).toList();

          // 2. Aplicar ordenação
          final finalList = applySorting(filteredItems);

          return ListView.builder(
            itemCount: finalList.length,
            itemBuilder: (context, index) {
              final promo = finalList[index];

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
          );
        },
      ),
    );
  }
}
