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
                      // Navega según el tipo
                      switch (place['type']) {
                        case 'hotel':
                          Navigator.pushNamed(context, '/hotel');
                          break;
                        case 'bar':
                          Navigator.pushNamed(context, '/bar');
                          break;
                        case 'restaurant':
                          Navigator.pushNamed(context, '/restaurant');
                          break;
                        case 'tourist':
                          Navigator.pushNamed(context, '/theater');
                          break;
                        case 'mall':
                          Navigator.pushNamed(context, '/mall');
                          break;
                        // Agrega más casos si tienes más tipos
                        default:
                          break;
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}