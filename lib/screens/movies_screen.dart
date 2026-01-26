import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';
import 'package:mvv_managements/models/movies_model.dart';
import 'package:mvv_managements/repositories/movies_repo.dart';
import 'package:mvv_managements/screens/favorites_screen.dart';
import 'package:mvv_managements/services/init_getit.dart';
import 'package:mvv_managements/services/navigation_service.dart';
import 'package:mvv_managements/widgets/movies/movie_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final List<MovieModel> movies = [];
  int currentPage = 1;
  bool isFetching = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMoreMovies();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      _fetchMoreMovies();
    }
  }

  Future<void> _fetchMoreMovies() async {
    if (isFetching) return;

    setState(() {
      isFetching = true;
    });

    try {
      final List<MovieModel> fetchedMovies = await getIt<MoviesRepository>()
          .fetchMovies(page: currentPage);
      setState(() {
        movies.addAll(fetchedMovies);
        currentPage++;
        isFetching = false;
      });
    } catch (e) {
      setState(() {
        isFetching = false;
      });
      print("Error fetching movies: $e");
      getIt<NavigationService>().showSnackBar(
        message: 'Failed to fetch movies',
      );
    } finally {
      setState(() {
        isFetching = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              // final List<MovieGenre> genres = await getIt<MoviesRepository>()
              //     .fetchGenres();
              // if (genres.isNotEmpty) {
              //   print("GENRES $genres");
              // }
            },
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: movies.length + (isFetching ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MoviesWidget(movies[index]),
          );
        },
      ),
    );
  }
}
