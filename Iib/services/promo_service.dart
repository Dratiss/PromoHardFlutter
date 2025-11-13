import 'dart:convert';
import 'package:http/http.dart' as http;

class PromoService {
  static const String apiUrl =
      "https://raw.githubusercontent.com/Dratiss/PromoHardAPI/main/promos.json";

  static Future<List<dynamic>> getPromotions() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro ao carregar promoções");
    }
  }
}
