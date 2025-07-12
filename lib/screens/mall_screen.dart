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
    'image': 'assets/mall.jpg',
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
            buildRichText(
              label: 'Descripción',
              text: 'Centro comercial moderno y completo con tiendas, restaurantes, cine, y entretenimiento familiar.',
            ),
            SizedBox(height: 8),
            buildRichText(
              label: 'Horario',
              text: '10:00 - 21:00',
            ),
            SizedBox(height: 8),
            buildInfoRow(
              icon: Icons.location_on,
              label: 'Dirección',
              text: 'Av. Felipe II y Autopista Cuenca-Azogues',
            ),
            SizedBox(height: 8),
            buildInfoRow(
              icon: Icons.phone,
              label: 'Teléfono',
              text: '(07) 409 6300',
            ),
            SizedBox(height: 8),
            buildRichText(
              label: 'Historia',
              text: 'Inaugurado en 2002, el Mall del Río es uno de los centros comerciales más grandes y concurridos de Cuenca, convirtiéndose en un referente de compras y recreación.',
            ),
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
