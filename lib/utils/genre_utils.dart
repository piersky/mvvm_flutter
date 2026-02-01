import 'package:flutter/material.dart';
import 'package:mvv_managements/models/genres_model.dart';
import 'package:mvv_managements/repositories/movies_repo.dart';
import 'package:mvv_managements/services/init_getit.dart';
import 'package:mvv_managements/view_models/movies_provider.dart';
import 'package:provider/provider.dart';

class GenreUtils {
  static List<MovieGenre> movieGenreNames(
    List<int> genreIds,
    BuildContext context,
  ) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final moviesRepository = getIt<MoviesRepository>();
    moviesRepository.fetchGenres();
    final genres = moviesProvider.genresList;

    List<MovieGenre> genreNames = [];

    for (var genreId in genreIds) {
      final genre = genres.firstWhere(
        (genre) => genre.id == genreId,
        orElse: () => MovieGenre(id: 584454, name: 'Unknown'),
      );
      genreNames.add(genre);
    }

    return genreNames;
  }
}
