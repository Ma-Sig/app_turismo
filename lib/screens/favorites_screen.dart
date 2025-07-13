import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesManager.favorites;
    return Scaffold(
      appBar: AppBar(title: Text('Favoritos')),
      body: favorites.isEmpty
          ? Center(child: Text('No hay favoritos aún.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final place = favorites[index];
                return Card(
                  child: ListTile(
                    leading: place['image'] != null && place['image']!.isNotEmpty
                        ? Image.asset(place['image']!, width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.place),
                    title: Text(place['name'] ?? ''),
                    subtitle: Text(place['address'] ?? ''),
                    onTap: () {
                      final type = place['type'];
                      final route = _getRouteForType(type);
                      if (route != null) {
                        Navigator.pushNamed(
                          context,
                          route,
                          arguments: place, // <-- pasa el lugar como argumento
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }

  String? _getRouteForType(String? type) {
    switch (type) {
      case 'hotel':
        return '/hotel';
      case 'bar':
        return '/bar';
      case 'restaurant':
        return '/restaurant';
      case 'tourist':
        return '/theater';
      case 'mall':
        return '/mall';
      default:
        return null;
    }
  }
}
