import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        AppIcons.favoriteRounded,
        // color: Colors.red,
        size: 20,
      ),
      onPressed: () {
        // Favorite action
      },
    );
  }
}
