import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mvv_managements/constants/api_constants.dart';
import 'package:mvv_managements/models/genres_model.dart';
import 'package:mvv_managements/models/movies_model.dart';

class ApiService {
  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    final url =
        "${ApiConstants.baseUrl}${ApiConstants.moviesEndpoint}?language=en-US&page=$page";
    final response = await http.get(
      Uri.parse(url),
      headers: ApiConstants.headers,
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("Movies fetched successfully: ${response.body}");
      }
      final data = jsonDecode(response.body);
      return List.from(
        data['results'],
      ).map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      if (kDebugMode) {
        print("Failed to fetch movies: ${response.statusCode}");
      }
      throw Exception("Failed to load movies : ${response.statusCode}");
    }
  }

  Future<List<MovieGenre>> fetchGenres() async {
    final url =
        "${ApiConstants.baseUrl}${ApiConstants.genresEndpoint}?language=en-US";
    final response = await http.get(
      Uri.parse(url),
      headers: ApiConstants.headers,
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("Genres fetched successfully: ${response.body}");
      }
      final data = jsonDecode(response.body);
      return List.from(
        data['genres'],
      ).map((genre) => MovieGenre.fromJson(genre)).toList();
    }
    return [];
  }
}
