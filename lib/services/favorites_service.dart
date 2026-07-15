import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Guarda os favoritos e os persiste no aparelho (shared_preferences),
/// para que não sejam perdidos ao fechar o app.
class FavoritesService {
  static const String _storageKey = "favorites";

  // Lista em memória (espelho do que está salvo no disco).
  static List<Map<String, dynamic>> favorites = [];

  /// Carrega os favoritos salvos. Deve ser chamado no main() antes do runApp.
  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = json.decode(raw) as List<dynamic>;
      favorites = decoded
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } catch (_) {
      favorites = [];
    }
  }

  static Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, json.encode(favorites));
  }

  static void addFavorite(Map<String, dynamic> promo) {
    if (!favorites.any((item) => item["title"] == promo["title"])) {
      favorites.add(promo);
      _save();
    }
  }

  static void removeFavorite(Map<String, dynamic> promo) {
    favorites.removeWhere((item) => item["title"] == promo["title"]);
    _save();
  }

  static bool isFavorite(String title) {
    return favorites.any((item) => item["title"] == title);
  }
}
