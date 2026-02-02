import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:mvv_managements/screens/movie_details_screen.dart';
import 'package:mvv_managements/services/init_getit.dart';
import 'package:mvv_managements/services/navigation_service.dart';
import 'package:mvv_managements/widgets/movies/favorite_button.dart';
import 'package:mvv_managements/widgets/movies/genres_widget.dart';
import 'package:provider/provider.dart';
import '../cache_image.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({
    super.key,
    // required this.movie
  });
  // final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            getIt<NavigationService>().navigator(
              ChangeNotifierProvider.value(
                value: moviesProvider,
                child: MovieDetailsScreen(movie: moviesProvider),
              ),
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
                    tag: moviesProvider.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedImageWidget(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500/${moviesProvider.posterPath}",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          moviesProvider.title,
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
                            Text(
                              "${moviesProvider.voteAverage.toStringAsFixed(1)}/10",
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GenresListWidget(movieModel: moviesProvider),
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
                            Text(
                              moviesProvider.releaseDate,
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            FavoriteButton(movieModel: moviesProvider),
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
