import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String apiKey = dotenv.get('TMDB_API_KEY');
  static String bearerToken = dotenv.get('TMDB_TOKEN');

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String moviesEndpoint = '/movie/popular';
  static Map<String, String> get headers => {
    'Authorization': 'Bearer $bearerToken',
    'accept': 'application/json;',
  };
}
