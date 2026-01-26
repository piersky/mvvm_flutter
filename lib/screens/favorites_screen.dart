import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';
import 'package:mvv_managements/widgets/movies/movie_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.delete, color: Colors.red),
            onPressed: () {
              // Favorite action
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("CIAO"), //MoviesWidget(),
          );
        },
      ),
    );
  }
}
