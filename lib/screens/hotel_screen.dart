import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class HotelScreen extends StatefulWidget {
  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> with SingleTickerProviderStateMixin {
  final Map<String, String> hotelPlace = {
    'name': 'Hotel Oro Verde',
    'address': 'Av. Ordóñez Lasso s/n y Felipe II',
    'image': 'assets/hotel.jpg',
    'type': 'hotel',
  };

  late TabController _tabController;

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
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  Widget buildGeneralView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/hotel.jpg'),
          SizedBox(height: 8),
          Text('Hotel Oro Verde', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('4.8 ★★★★★'),
          Divider(),
          buildRichText(
            label: 'Descripción',
            text: 'Hotel de lujo con servicios de alta gama, restaurante gourmet y spa.',
          ),
          SizedBox(height: 8),
          buildRichText(label: 'Horario', text: '24 horas'),
          SizedBox(height: 8),
          buildInfoRow(
            icon: Icons.location_on,
            label: 'Dirección',
            text: 'Av. Ordóñez Lasso s/n y Felipe II',
          ),
          SizedBox(height: 8),
          buildInfoRow(
            icon: Icons.phone,
            label: 'Teléfono',
            text: '(07) 413 4500',
          ),
          SizedBox(height: 8),
          buildRichText(
            label: 'Historia',
            text: 'Parte de la cadena de hoteles Oro Verde, reconocido por su elegancia y servicio en Ecuador.',
          ),
          SizedBox(height: 10),
          Text('Comparativa antes y ahora:', style: TextStyle(fontWeight: FontWeight.bold)),
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
    );
  }

  Widget buildAboutView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hotel reconocido por su excelencia y hospitalidad desde su fundación.'),
          Divider(height: 24),
          Text('Accesibilidad', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.accessible_forward),
                title: Text('Acceso para silla de ruedas'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.elevator),
                title: Text('Elevadores disponibles'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.hearing),
                title: Text('Asistencia auditiva'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.blind),
                title: Text('Información en braille'),
                trailing: Icon(Icons.check),
              ),
            ],
          ),
          Divider(height: 24),
          Text('Comodidades', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.wc),
                title: Text('Baños privados'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.local_parking),
                title: Text('Parqueadero'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.pool),
                title: Text('Piscina'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.restaurant),
                title: Text('Restaurante gourmet'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.spa),
                title: Text('Spa & Bienestar'),
                trailing: Icon(Icons.check),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Oro Verde'),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: _toggleFavorite,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Vista General'),
            Tab(text: 'Sobre'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildGeneralView(),
          buildAboutView(),
        ],
      ),
    );
  }
}
