import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class BarScreen extends StatefulWidget {
  @override
  State<BarScreen> createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen> {
  final Map<String, String> barPlace = {
    'name': 'Jodoco Belgian Bistro',
    'address': 'Honorato Vásquez 6-41 y Hermano Miguel',
    'image': 'assets/bar.jpg',
    'type': 'bar',
  };

  bool get isFavorite => FavoritesManager.isFavorite(barPlace);

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoritesManager.remove(barPlace);
      } else {
        FavoritesManager.add(barPlace);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jodoco Belgian Bistro'),
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
            Image.asset('assets/bar.jpg'),
            SizedBox(height: 8),
            Text('Jodoco Belgian Bistro', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('4.7 ★★★★☆'),
            Divider(),
            Text('Descripción: Bar estilo belga con una amplia selección de cervezas artesanales, comida gourmet y ambiente relajado.'),
            SizedBox(height: 10),
            Text('Horario: 17:00 - 00:00'),
            Text('Dirección: Honorato Vásquez 6-41 y Hermano Miguel'),
            Text('Teléfono: 099 878 2842'),
            Text('Historia: Fundado en 2015, se ha convertido en un punto de encuentro favorito para los amantes de la cerveza artesanal y buena comida.'),
          SizedBox(height: 10),
            Text('Comparativa antes y ahora:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 120, // Ajusta la altura aquí
                    child: Image.asset('assets/bar_antes.jpg', fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 120, // Misma altura
                    child: Image.asset('assets/bar.jpg', fit: BoxFit.cover),
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