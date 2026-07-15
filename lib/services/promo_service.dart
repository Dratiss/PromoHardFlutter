import 'dart:convert';
import 'package:http/http.dart' as http;

class PromoService {
  final String apiUrl =
      "https://raw.githubusercontent.com/Dratiss/PromoHardApi/main/Promotions.json";

  Future<List<dynamic>> fetchPromotions() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List promotions = data["promotions"] ?? [];

      for (var promo in promotions) {
        // ===========================================
        // PROCESSA EXPIRES_AT → DateTime
        // ===========================================
        if (promo["expires_at"] != null) {
          promo["expires_at_parsed"] = DateTime.tryParse(promo["expires_at"]);
        } else {
          promo["expires_at_parsed"] = null;
        }

        // ===========================================
        // GARANTIR QUE CATEGORIA EXISTE
        // ===========================================
        if (promo["category"] == null) {
          promo["category"] = "Diversos";
        }

        // ===========================================
        // GARANTIR QUE GRUPO EXISTE
        // ===========================================
        if (promo["group"] == null) {
          promo["group"] = "Diversos";
        }
      }

      return promotions;
    } else {
      throw Exception("Erro ao carregar promoções");
    }
  }
}
