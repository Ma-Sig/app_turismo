import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class HotelScreen extends StatefulWidget {
  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  final Map<String, String> hotelPlace = {
    'name': 'Hotel Oro Verde',
    'address': 'Av. Ordóñez Lasso s/n y Felipe II',
    'image': 'assets/hotel.jpg',
    'type': 'hotel',
  };

  bool get isFavorite => FavoritesManager.isFavorite(hotelPlace);

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoritesManager.remove(hotelPlace);
      } else {
        FavoritesManager.add(hotelPlace);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Oro Verde'),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/hotel.jpg'),
            SizedBox(height: 8),
            Text('Hotel Oro Verde',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('4.8 ★★★★★'),
            Divider(),
            Text(
              'Descripción: Hotel de lujo con servicios de alta gama, restaurante gourmet y spa.',
            ),
            Text('Horario: 24 horas'),
            Text('Dirección: Av. Ordóñez Lasso s/n y Felipe II'),
            Text('Teléfono: (07) 413 4500'),
            Text(
              'Historia: Parte de la cadena de hoteles Oro Verde, reconocido por su elegancia y servicio en Ecuador.',
            ),
            SizedBox(height: 10),
            Text('Comparativa antes y ahora:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Image.asset('assets/hotel_antes.jpg', fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Image.asset('assets/hotel.jpg', fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
