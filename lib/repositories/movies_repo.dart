import 'package:mvv_managements/models/genres_model.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:mvv_managements/services/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;

  MoviesRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    return await _apiService.fetchMovies(page: page);
  }

  List<MovieGenre> cachedGenres = [];

  Future<List<MovieGenre>> fetchGenres() async {
    return cachedGenres = await _apiService.fetchGenres();
  }
}
