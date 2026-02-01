import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';
import 'package:mvv_managements/view_models/favorites_provider.dart';
import 'package:mvv_managements/widgets/movies/movie_widget.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.delete, color: Colors.red),
            onPressed: () {
              favoritesProvider.clearAll();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: favoritesProvider.favoriteMovies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: favoritesProvider.favoriteMovies.isEmpty
                ? const Center(child: Text('No favorite movies'))
                : ChangeNotifierProvider.value(
                    value: favoritesProvider.favoriteMovies.reversed
                        .toList()[index],
                    child: const MoviesWidget(),
                  ),
          );
        },
      ),
    );
  }
}
