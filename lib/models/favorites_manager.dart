class FavoritesManager {
  static final List<Map<String, String>> favorites = [];
  
  static void add(Map<String, String> place) {
    if (!favorites.any((fav) => fav['name'] == place['name'])) {
      favorites.add(place);
    }
  }

  static void remove(Map<String, String> place) {
    favorites.removeWhere((fav) => fav['name'] == place['name']);
  }

  static bool isFavorite(Map<String, String> place) {
    return favorites.any((fav) => fav['name'] == place['name']);
  }
}