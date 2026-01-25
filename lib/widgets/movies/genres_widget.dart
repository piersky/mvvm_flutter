import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_constants.dart';

class GenresWidget extends StatefulWidget {
  const GenresWidget({super.key, required this.genres});

  final List<String> genres;

  @override
  State<GenresWidget> createState() => _GenresWidgetState();
}

class _GenresWidgetState extends State<GenresWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List.generate(
        AppConstants.genres.length,
        (index) => _buildGenreChip(AppConstants.genres[index], context),
      ),
    );
  }

  Widget _buildGenreChip(String genre, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Text(
            genre,
            style: TextStyle(
              color: Theme.of(context).chipTheme.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
