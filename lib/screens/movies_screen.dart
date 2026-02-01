import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';
import 'package:mvv_managements/constants/theme_data.dart';
import 'package:mvv_managements/screens/favorites_screen.dart';
import 'package:mvv_managements/services/init_getit.dart';
import 'package:mvv_managements/services/navigation_service.dart';
import 'package:mvv_managements/view_models/movies_provider.dart';
import 'package:mvv_managements/view_models/theme_provider.dart';
import 'package:mvv_managements/widgets/movies/movie_widget.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    print("Built rebuild MoviesScreen");

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
          Consumer(
            builder: (context, ThemeProvider themeProvider, child) {
              print("Built rebuild Theme IconButton");

              return IconButton(
                icon: Icon(
                  themeProvider.themeMode == AppThemeData.darkTheme
                      ? AppIcons.darkMode
                      : AppIcons.lightMode,
                ),
                onPressed: () async {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<MoviesProvider>(
        builder: (context, MoviesProvider moviesProvider, child) {
          if (moviesProvider.isLoading && moviesProvider.moviesList.isEmpty) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (moviesProvider.fetchMoviesError.isNotEmpty) {
            return Center(child: Text(moviesProvider.fetchMoviesError));
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !moviesProvider.isLoading) {
                moviesProvider.getMovies();
                return true;
              }
              return false;
            },
            child: ListView.builder(
              itemCount: moviesProvider.moviesList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: moviesProvider.moviesList[index],
                  child: const MoviesWidget(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
