import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_constants.dart';
import 'package:mvv_managements/constants/app_icons.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:mvv_managements/screens/favorites_screen.dart';
import 'package:mvv_managements/screens/movie_details_screen.dart';
import 'package:mvv_managements/services/init_getit.dart';
import 'package:mvv_managements/services/navigation_service.dart';
import 'package:mvv_managements/widgets/movies/favorite_button.dart';
import '../cache_image.dart';

class MoviesWidget extends StatelessWidget {
  final MovieModel movie;

  const MoviesWidget(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            getIt<NavigationService>().navigator(
              MovieDetailsScreen(movie: movie),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'movie_${movie.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedImageWidget(
                        imageUrl: movie.posterPath.isNotEmpty
                            ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
                            : AppConstants.defaultImageUrl,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title.isNotEmpty ? movie.title : "Movie Title",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 5),
                            Text("${movie.voteAverage.toStringAsFixed(1)}/10"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // GenresWidget(
                        //   genres:
                        //       movie.genreIds
                        //           ?.map(
                        //             (id) =>
                        //                 AppConstants.genresMap[id] ?? "Unknown",
                        //           )
                        //           .toList() ??
                        //       [],
                        // ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              AppIcons.watchLaterOutlined,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Release Date",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            FavoriteButton(
                              onPressed: () {
                                getIt<NavigationService>().navigator(
                                  const FavoritesScreen(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
