import 'package:mvv_managements/models/genres_model.dart';
import 'package:mvv_managements/repositories/movies_repo.dart';
import 'package:mvv_managements/services/init_getit.dart';

class GenreUtils {
  static List<MovieGenre> movieGenreNames({required List<int> genreIds}) {
    final moviesRepository = getIt<MoviesRepository>();
    moviesRepository.fetchGenres();
    final genres = []; //TODO: await moviesRepository.fetchGenres();
    List<MovieGenre> genreNames = [];

    // print('Mapping genre IDs: $genreIds');
    // print('Available genres: $genres');

    for (var genreId in genreIds) {
      final genre = genres.firstWhere(
        (genre) => genre.id == genreId,
        orElse: () => MovieGenre(id: 584454, name: 'Unknown'),
      );
      genreNames.add(genre);
    }
    print('Mapped genres: $genreNames');
    return genreNames;
  }
}
