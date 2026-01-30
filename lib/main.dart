import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvv_managements/screens/movies_screen.dart';
import 'package:mvv_managements/screens/splash_screen.dart';
import 'package:mvv_managements/services/init_getit.dart';
import 'package:mvv_managements/services/navigation_service.dart';
import 'package:mvv_managements/view_models/movies_provider.dart';
import 'package:mvv_managements/view_models/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  setupLocator(); // Initialize GetIt service locator
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) async {
    await dotenv.load(fileName: "assets/.env");
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(), //..loadTheme(),
        ),
        ChangeNotifierProvider<MoviesProvider>(create: (_) => MoviesProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            theme: themeProvider.themeMode,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
