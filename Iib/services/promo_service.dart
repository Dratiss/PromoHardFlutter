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

      // Converte expires_at para DateTime e organiza por expiração
      for (var promo in promotions) {
        if (promo["expires_at"] != null) {
          promo["expires_at_parsed"] =
              DateTime.tryParse(promo["expires_at"]);
        } else {
          promo["expires_at_parsed"] = null;
        }
      }

      return promotions;
    } else {
      throw Exception("Erro ao carregar promoções");
    }
  }
}
