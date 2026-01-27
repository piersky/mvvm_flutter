import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';

class FavoriteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // bool isFavorite = favoritesList.contains(widget.movie.id);

    return IconButton(
      icon: Icon(
        AppIcons.favoriteOutlinedRounded,
        size: 20,
        color: Colors.grey,
      ),
      onPressed: () {
        // TODO
      },
    );
  }
}
