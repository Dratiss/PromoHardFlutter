import 'package:flutter/material.dart';
import '../services/promo_service.dart';
import '../widgets/promocard.dart';
import '../widgets/loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PromoService promoService = PromoService();
  late Future<List<dynamic>> promotions;

  @override
  void initState() {
    super.initState();
    promotions = promoService.fetchPromotions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PromoHard"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: promotions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar promoções",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Nenhuma promoção encontrada",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final promo = items[index];
              return PromoCard(
                title: promo["title"],
                normalPrice: promo["normal_price"],
                promoPrice: promo["promo_price"],
                imageUrl: promo["image"],
                store: promo["store"],
                link: promo["link"],
              );
            },
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
