import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  final List<MovieModel> _favoriteMovies = [];
  List<MovieModel> get favoriteMovies => _favoriteMovies;
  final favKey = "favsKey";

  bool isFavorite(MovieModel movieModel) {
    return _favoriteMovies.any((movie) => movie.id == movieModel.id);
  }

  void addOrRemoveFromFavorites(MovieModel movieModel) {
    if (isFavorite(movieModel)) {
      _favoriteMovies.removeWhere((movie) => movie.id == movieModel.id);
    } else {
      _favoriteMovies.add(movieModel);
    }
    saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = _favoriteMovies
        .map((movie) => jsonEncode(movie.toJson()))
        .toList();
    await prefs.setStringList(favKey, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(favKey) ?? [];
    _favoriteMovies.clear();
    _favoriteMovies.addAll(
      stringList.map((movie) => MovieModel.fromJson(json.decode(movie))),
    );
    notifyListeners();
  }

  void clearAll() {
    _favoriteMovies.clear();
    notifyListeners();
    saveFavorites();
  }
}
