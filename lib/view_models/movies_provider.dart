import 'package:flutter/material.dart';
import 'package:mvv_managements/models/genres_model.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:mvv_managements/repositories/movies_repo.dart';
import 'package:mvv_managements/services/init_getit.dart';

class MoviesProvider with ChangeNotifier {
  final List<MovieModel> _moviesList = [];

  List<MovieModel> get moviesList => _moviesList;

  List<MovieGenre> _genresList = [];
  List<MovieGenre> get genresList => _genresList;

  int _currentPage = 1;
  int get currentPage => _currentPage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _fetchMoviesError = '';
  String get fetchMoviesError => _fetchMoviesError;

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getMovies({bool loadMore = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_genresList.isEmpty) {
        _genresList = await _moviesRepository.fetchGenres();
      }
      List<MovieModel> movies = await _moviesRepository.fetchMovies(
        page: _currentPage,
      );

      _moviesList.addAll(movies);
      _currentPage++;
    } catch (error) {
      print(error);
      _fetchMoviesError = error.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
