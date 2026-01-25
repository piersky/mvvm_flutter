import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:mvv_managements/screens/favorites_screen.dart';
import 'package:mvv_managements/services/api_service.dart';
import 'package:mvv_managements/services/init_getit.dart';
import 'package:mvv_managements/services/navigation_service.dart';
import 'package:mvv_managements/widgets/movies/movie_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.favoriteRounded, color: Colors.red),
            onPressed: () {
              getIt<NavigationService>().navigator(const FavoritesScreen());
            },
          ),
          IconButton(
            icon: const Icon(AppIcons.darkMode),
            onPressed: () async {
              // Dark mode action
              final List<MoviesModel> movies = await getIt<ApiService>()
                  .fetchMovies(page: 1);
              if (movies.isNotEmpty) {
                print("MOVIES $movies");
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MoviesWidget(),
          );
        },
      ),
    );
  }
}
