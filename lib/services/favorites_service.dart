class FavoritesService {
  static List<Map<String, dynamic>> favorites = [];

  static void addFavorite(Map<String, dynamic> promo) {
    if (!favorites.any((item) => item["title"] == promo["title"])) {
      favorites.add(promo);
    }
  }

  static void removeFavorite(Map<String, dynamic> promo) {
    favorites.removeWhere((item) => item["title"] == promo["title"]);
  }

  static bool isFavorite(String title) {
    return favorites.any((item) => item["title"] == title);
  }
}
