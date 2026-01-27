import 'package:flutter/material.dart';
import 'package:mvv_managements/models/genres_model.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:mvv_managements/utils/genre_utils.dart';

class GenresListWidget extends StatelessWidget {
  final MovieModel movie;
  const GenresListWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final List<MovieGenre> genres = GenreUtils.movieGenreNames(
      genreIds: movie.genreIds,
    );

    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List.generate(
        genres.length,
        (index) => _buildGenreChip(genres[index].name, context),
      ),
    );
  }

  Widget _buildGenreChip(String genre, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Text(
            genre,
            style: TextStyle(
              color: Theme.of(context).chipTheme.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
