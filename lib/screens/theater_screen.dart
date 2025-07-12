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
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: 'Descripción: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Espacio cultural icónico de Cuenca que acoge conciertos, obras de teatro y eventos artísticos.'),
                ],
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: 'Horario: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '09:00 - 21:00'),
                ],
              ),
            ),
            SizedBox(height: 8),
            buildInfoRow(
              icon: Icons.location_on,
              label: 'Dirección',
              text: 'Mariscal Sucre y Luis Cordero',
            ),
            SizedBox(height: 8),
            buildInfoRow(
              icon: Icons.phone,
              label: 'Teléfono',
              text: '(07) 282 7689',
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: 'Historia: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Inaugurado en 1878, es uno de los teatros más antiguos y representativos de la ciudad.'),
                ],
              ),
            ),
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
