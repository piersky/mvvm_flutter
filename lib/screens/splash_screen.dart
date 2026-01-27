import 'package:flutter/material.dart';
import 'package:mvv_managements/repositories/movies_repo.dart';
import 'package:mvv_managements/screens/movies_screen.dart';
import 'package:mvv_managements/services/init_getit.dart';
import 'package:mvv_managements/services/navigation_service.dart';
import 'package:mvv_managements/widgets/error_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  String _errorMessage = '';
  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _moviesRepository.fetchMovies();
      await getIt<NavigationService>().navigatorReplace(MoviesScreen());
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : MyErrorWidget(errorText: _errorMessage, onRetry: loadData),
    );
  }
}
