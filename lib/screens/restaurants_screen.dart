import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> with SingleTickerProviderStateMixin {
  final Map<String, String> restaurantPlace = {
    'name': 'Tiesto’s',
    'address': 'Juan Jaramillo 7-34 y Borrero',
    'image': 'assets/restaurante.jpg',
    'type': 'restaurant',
  };

  late TabController _tabController;

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
          buildRichText(label: 'Horario', text: '12:00 - 22:00'),
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
    );
  }

  Widget buildAboutView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Restaurante icónico en Cuenca con platos típicos reinventados.'),
          Divider(height: 24),
          Text('Accesibilidad', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.accessible_forward),
                title: Text('Entrada accesible'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.elevator),
                title: Text('Rampa de acceso'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.hearing),
                title: Text('Atención adaptada para personas con discapacidad auditiva'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.visibility_off),
                title: Text('Menú accesible para baja visión'),
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
                title: Text('Baños disponibles'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.wifi),
                title: Text('Wi-Fi gratis'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.family_restroom),
                title: Text('Ambiente familiar'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.restaurant_menu),
                title: Text('Menú vegetariano'),
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
        title: Text('Vista del Restaurante'),
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
