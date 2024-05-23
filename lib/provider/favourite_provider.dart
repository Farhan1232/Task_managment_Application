

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  Set<String> _favorites = {};
  late SharedPreferences _prefs;

  FavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _prefs = await SharedPreferences.getInstance();
    final savedFavorites = _prefs.getStringList('favorites');
    if (savedFavorites != null) {
      _favorites = savedFavorites.toSet();
    }
  }

  // Method to add a todo item to favorites
  Future<void> addFavorite(String todoId) async {
    _favorites.add(todoId);
    await _saveFavorites();
    notifyListeners();
  }

  // Method to remove a todo item from favorites
  Future<void> removeFavorite(String todoId) async {
    _favorites.remove(todoId);
    await _saveFavorites();
    notifyListeners();
  }

  // Method to check if a todo item is a favorite
  bool isFavorite(String todoId) {
    return _favorites.contains(todoId);
  }

  // Getter to return favorite items
  Set<String> get favoriteItems => _favorites;

  Future<void> _saveFavorites() async {
    await _prefs.setStringList('favorites', _favorites.toList());
  }
}
