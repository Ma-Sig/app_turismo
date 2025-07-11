import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class MallScreen extends StatefulWidget {
  @override
  State<MallScreen> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> {
  final Map<String, String> MallPlace = {
    'name': 'Mall del Río',
    'address': 'Av. Felipe II y Autopista Cuenca-Azogues',
    'image': 'assets/Mall.jpg',
    'type': 'mall',
  };

  bool get isFavorite => FavoritesManager.isFavorite(MallPlace);

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoritesManager.remove(MallPlace);
      } else {
        FavoritesManager.add(MallPlace);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista General'),
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
            Image.asset('assets/mall.jpg'),
            SizedBox(height: 8),
            Text('Mall del Río', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('4.7 ★★★★☆'),
            Divider(),
            Text('Descripción: Centro comercial moderno y completo con tiendas, restaurantes, cine, y entretenimiento familiar.'),
            SizedBox(height: 10),
            Text('Horario: 10:00 - 21:00'),
            Text('Dirección: Av. Felipe II y Autopista Cuenca-Azogues'),
            Text('Teléfono: (07) 409 6300'),
            Text('Historia: Inaugurado en 2002, el Mall del Río es uno de los centros comerciales más grandes y concurridos de Cuenca, convirtiéndose en un referente de compras y recreación.'),
            SizedBox(height: 10),
            Text('Comparativa antes y ahora:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Image.asset('assets/mall_antes.jpg', fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Image.asset('assets/mall.jpg', fit: BoxFit.cover),
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
