import 'package:flutter/material.dart';
import 'package:mvv_managements/screens/movies_screen.dart';
import 'package:mvv_managements/services/init_getit.dart';
import 'package:mvv_managements/services/navigation_service.dart';
import 'package:mvv_managements/view_models/favorites_provider.dart';
import 'package:mvv_managements/view_models/movies_provider.dart';
import 'package:mvv_managements/widgets/error_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _loadInitialData(BuildContext context) async {
    await Future.microtask(() async {
      if (!context.mounted) return;
      await Provider.of<FavoritesProvider>(
        context,
        listen: false,
      ).loadFavorites();
      if (!context.mounted) return;
      await Provider.of<MoviesProvider>(context, listen: false).getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: _loadInitialData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            if (moviesProvider.genresList.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                getIt<NavigationService>().navigatorReplace(
                  const MoviesScreen(),
                );
              });
            }
            return Provider.of<MoviesProvider>(context).isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Center(
                    child: MyErrorWidget(
                      errorText: snapshot.error.toString(),
                      onRetry: () async {
                        _loadInitialData(context);
                      },
                    ),
                  );
          } else {
            // Navigate to the main screen after loading
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MoviesScreen()),
              );
            });
            return Container(); // Return an empty container while navigating
          }
        },
      ),
    );
  }
}
