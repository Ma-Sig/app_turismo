import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/theater_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/config_screen.dart';
import 'screens/about_screen.dart';
import 'screens/bar_screen.dart';
import 'screens/hotel_screen.dart';
import 'screens/tourist_points_screen.dart';
import 'screens/bar_points_screen.dart';
import 'screens/hotel_points_screen.dart';
import 'screens/restaurants_screen.dart';
import 'screens/restaurants_points_screen.dart';
import 'screens/mall_screen.dart';
import 'screens/shopping_points_screen.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) => MaterialApp(
        title: 'Turismo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.dark,
        ),
        themeMode: mode,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/home': (context) => HomeScreen(),
          '/favorites': (context) => FavoritesScreen(),
          '/theater': (context) => TheaterScreen(),
          '/bar': (context) => BarScreen(),
          '/hotel': (context) => HotelScreen(),
          '/mall': (context) => MallScreen(),
          '/restaurant': (context) => RestaurantScreen(),
          '/profile': (context) => ProfileScreen(),
          '/config': (context) => ConfigScreen(),
          '/about': (context) => AboutScreen(),
          '/tourist_points': (context) => TouristPointsScreen(),
          '/bar_points': (context) => BarPointsScreen(),
          '/hotel_points': (context) => HotelPointsScreen(),
          '/shopping_points': (context) => ShoppingPointsScreen(),
          '/restaurant_points': (context) => RestaurantPointsScreen(),
        },
      ),
    );
  }
}