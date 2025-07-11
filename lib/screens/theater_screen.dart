import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class TheaterScreen extends StatefulWidget {
  @override
  State<TheaterScreen> createState() => _TheaterScreenState();
}

class _TheaterScreenState extends State<TheaterScreen> {
  final Map<String, String> theaterPlace = {
    'name': 'Teatro Sucre',
    'address': 'Mariscal Sucre y Luis Cordero',
    'image': 'assets/theater.jpg',
    'type': 'theater',
  };

  bool get isFavorite => FavoritesManager.isFavorite(theaterPlace);

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoritesManager.remove(theaterPlace);
      } else {
        FavoritesManager.add(theaterPlace);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teatro Sucre'),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/theater.jpg'),
            SizedBox(height: 8),
            Text('Teatro Sucre', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('4.6 ★★★★☆'),
            Divider(),
            Text('Descripción: Espacio cultural icónico de Cuenca que acoge conciertos, obras de teatro y eventos artísticos.'),
            Text('Horario: 09:00 - 21:00'),
            Text('Dirección: Mariscal Sucre y Luis Cordero'),
            Text('Teléfono: (07) 282 7689'),
            Text('Historia: Inaugurado en 1878, es uno de los teatros más antiguos y representativos de la ciudad.'),
            SizedBox(height: 10),
            Text('Comparativa antes y ahora:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Image.asset('assets/teatro_antes.jpg', fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Image.asset('assets/theater.jpg', fit: BoxFit.cover),
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
