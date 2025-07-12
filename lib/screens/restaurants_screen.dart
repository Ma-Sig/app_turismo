import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final Map<String, String> restaurantPlace = {
    'name': 'Tiesto’s',
    'address': 'Juan Jaramillo 7-34 y Borrero',
    'image': 'assets/restaurante.jpg',
  };

  bool get isFavorite => FavoritesManager.isFavorite(restaurantPlace);

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoritesManager.remove(restaurantPlace);
      } else {
        FavoritesManager.add(restaurantPlace);
      }
    });
  }

  Widget buildInfoRow({required IconData icon, required String label, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: [
                TextSpan(text: '$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRichText({required String label, required String text}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16),
        children: [
          TextSpan(text: '$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista del Restaurante'),
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
            Image.asset('assets/restaurante.jpg'),
            SizedBox(height: 8),
            Text('Tiesto’s', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('4.8 ★★★★★'),
            Divider(),
            buildRichText(
              label: 'Descripción',
              text: 'Restaurante gourmet de cocina ecuatoriana con presentaciones únicas y ambiente elegante.',
            ),
            SizedBox(height: 8),
            buildRichText(
              label: 'Horario',
              text: '12:00 - 22:00',
            ),
            SizedBox(height: 8),
            buildInfoRow(
              icon: Icons.location_on,
              label: 'Dirección',
              text: 'Juan Jaramillo 7-34 y Borrero, Cuenca',
            ),
            SizedBox(height: 8),
            buildInfoRow(
              icon: Icons.phone,
              label: 'Teléfono',
              text: '(07) 283-2007',
            ),
            SizedBox(height: 8),
            buildRichText(
              label: 'Historia',
              text: 'Fundado en 2005, Tiesto’s ha sido reconocido por reinventar la cocina ecuatoriana con creatividad y calidad.',
            ),
            SizedBox(height: 10),
            Text('Comparativa antes y ahora:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Image.asset('assets/restaurante_antes.jpg', fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Image.asset('assets/restaurante.jpg', fit: BoxFit.cover),
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
