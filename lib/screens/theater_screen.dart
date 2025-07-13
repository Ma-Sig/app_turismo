import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class TheaterScreen extends StatefulWidget {
  @override
  State<TheaterScreen> createState() => _TheaterScreenState();
}

class _TheaterScreenState extends State<TheaterScreen> with SingleTickerProviderStateMixin {
  final Map<String, String> theaterPlace = {
    'name': 'Teatro Sucre',
    'address': 'Mariscal Sucre y Luis Cordero',
    'image': 'assets/theater.jpg',
    'type': 'tourist',
  };

  late TabController _tabController;

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
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildGeneralView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/theater.jpg'),
          SizedBox(height: 8),
          Text('Teatro Sucre', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('4.9 ★★★★★ (29,127)', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text(
            'Famoso teatro renacentista de 1896, auge de la época republicana en Cuenca, con capacidad para conciertos y eventos culturales.',
            style: TextStyle(fontSize: 16),
          ),
          Divider(height: 24),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Mariscal Sucre y Luis Cordero'),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('https://teatrocom.ec/'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('(593) 3622-1880'),
          ),
          SizedBox(height: 16),
          Text('Fotos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset('assets/theater.jpg'),
                SizedBox(width: 8),
                Image.asset('assets/teatro_antes.jpg'),
                SizedBox(width: 8),
                Image.asset('assets/theater.jpg'),
              ],
            ),
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
        Text('Teatro famoso, inaugurado en el año 1896.'),
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
              leading: Icon(Icons.baby_changing_station),
              title: Text('Baños para niños'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              leading: Icon(Icons.accessible),
              title: Text('Rampas de acceso'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              leading: Icon(Icons.elevator),
              title: Text('Elevador para movilidad reducida'),
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
              title: Text('Baños'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              leading: Icon(Icons.family_restroom),
              title: Text('Se puede traer niños'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Restaurante disponible'),
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
        title: Text('Teatro Sucre'),
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
