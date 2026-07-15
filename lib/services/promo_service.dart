import 'dart:convert';
import 'package:http/http.dart' as http;

class PromoService {
  final String apiUrl =
      "https://raw.githubusercontent.com/Dratiss/PromoHardApi/main/Promotions.json";

  Future<List<dynamic>> fetchPromotions() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(_sanitize(response.body));

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

  // Compatibilidade: a Promotions.json atual vem embrulhada em código Dart
  // (const String fakeJson = """ ... """;) e com preços escapados como "R\$".
  // Isso não é JSON válido. Aqui extraímos o objeto entre o primeiro "{" e o
  // último "}" e desfazemos o "\$". Quando a API virar JSON puro, este passo
  // vira um no-op (nada a extrair, nada a substituir).
  String _sanitize(String body) {
    final start = body.indexOf('{');
    final end = body.lastIndexOf('}');
    var json = (start >= 0 && end > start) ? body.substring(start, end + 1) : body;
    return json.replaceAll(r'\$', r'$');
  }
}
