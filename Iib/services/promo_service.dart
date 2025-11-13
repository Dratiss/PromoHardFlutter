import 'dart:convert';
import 'package:http/http.dart' as http;

class PromoService {
  final String apiUrl =
      "https://raw.githubusercontent.com/Dratiss/PromoHardApi/refs/heads/main/Promotions.json";

  Future<List<dynamic>> fetchPromotions() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["promotions"] ?? [];
    } else {
      throw Exception("Erro ao carregar promoções");
    }
  }
}
