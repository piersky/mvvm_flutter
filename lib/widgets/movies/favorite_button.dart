import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:mvv_managements/view_models/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final MovieModel movieModel;

  const FavoriteButton({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    // bool isFavorite = favoritesList.contains(widget.movie.id);

    return Consumer(
      builder: (context, FavoritesProvider favoriteProvider, _) {
        return IconButton(
          icon: Icon(
            favoriteProvider.isFavorite(movieModel)
                ? AppIcons.favoriteRounded
                : AppIcons.favoriteOutlinedRounded,
            size: 20,
            color: favoriteProvider.isFavorite(movieModel)
                ? Colors.red
                : Colors.grey,
          ),
          onPressed: () {
            favoriteProvider.addOrRemoveFromFavorites(movieModel);
          },
        );
      },
    );
  }
}
