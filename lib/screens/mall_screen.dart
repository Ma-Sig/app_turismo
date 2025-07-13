import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class MallScreen extends StatefulWidget {
  @override
  State<MallScreen> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> with SingleTickerProviderStateMixin {
  final Map<String, String> mallPlace = {
    'name': 'Mall del Río',
    'address': 'Av. Felipe II y Autopista Cuenca-Azogues',
    'image': 'assets/mall.jpg',
    'type': 'mall',
  };

  late TabController _tabController;

  bool get isFavorite => FavoritesManager.isFavorite(mallPlace);

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoritesManager.remove(mallPlace);
      } else {
        FavoritesManager.add(mallPlace);
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
          Image.asset('assets/mall.jpg'),
          SizedBox(height: 8),
          Text('Mall del Río', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('4.7 ★★★★☆'),
          Divider(),
          buildRichText(
            label: 'Descripción',
            text: 'Centro comercial moderno y completo con tiendas, restaurantes, cine y entretenimiento familiar.',
          ),
          SizedBox(height: 8),
          buildRichText(label: 'Horario', text: '10:00 - 21:00'),
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
            text: 'Inaugurado en 2002, es uno de los centros comerciales más grandes y concurridos de Cuenca.',
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
    );
  }

  Widget buildAboutView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Centro comercial con múltiples servicios y comodidades para toda la familia.'),
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
                leading: Icon(Icons.visibility_off),
                title: Text('Señalética para baja visión'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.hearing),
                title: Text('Asistencia auditiva en cine'),
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
                leading: Icon(Icons.local_parking),
                title: Text('Estacionamiento amplio'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Zona de compras'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.fastfood),
                title: Text('Zona de comidas'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Cine'),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                leading: Icon(Icons.child_friendly),
                title: Text('Áreas infantiles'),
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
        title: Text('Mall del Río'),
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
