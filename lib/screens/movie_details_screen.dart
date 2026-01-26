import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_constants.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:mvv_managements/widgets/cache_image.dart';
import 'package:mvv_managements/widgets/movies/favorite_button.dart';
import 'package:mvv_managements/widgets/movies/genres_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: 'movie_${movie.id}',
              child: SizedBox(
                height: size.height * 0.5,
                width: double.infinity,
                child: CachedImageWidget(
                  imageUrl: movie.posterPath.isNotEmpty
                      ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
                      : AppConstants.defaultImageUrl,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.4),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                const Text(
                                  'Genres',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20.0,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      '${movie.voteAverage.toStringAsFixed(1)}/10',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Spacer(),
                                    Text(
                                      movie.releaseDate,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                GenresWidget(genres: AppConstants.genres),
                                const SizedBox(height: 15.0),
                                Text(
                                  movie.overview,
                                  style: TextStyle(fontSize: 18.0),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: FavoriteButton(onPressed: () {}),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const BackButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
