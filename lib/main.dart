import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/book%20mark/views/bookmark_screen.dart';
import 'package:weather_app/pages/home/views/home_page.dart';
import 'package:weather_app/pages/splash/views/splash_screen.dart';
import 'package:weather_app/provider/weather_provider.dart';

import 'pages/search history/search_history.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherProvider>(
            create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const SplashScreen(),
          '/home': (_) => const HomePage(),
          '/search': (_) => const SearchHistoryPage(),
          '/bookmark': (_) => const BookmarkPage(),
        },
      ),
    );
  }
}
