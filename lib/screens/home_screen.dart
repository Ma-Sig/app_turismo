import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  Widget buildCategoryButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.green[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, size: 40, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/catedral.jpg', fit: BoxFit.fitWidth),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Ciudad de Cuenca',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                buildCategoryButton("Puntos Turísticos", Icons.place, () => Navigator.pushNamed(context, '/tourist_points'),),
                buildCategoryButton("Bares", Icons.local_bar, () => Navigator.pushNamed(context, '/bar_points'),),
                buildCategoryButton("Restaurantes", Icons.restaurant, ()  => Navigator.pushNamed(context, '/restaurant_points'),),
                buildCategoryButton("Shoppings", Icons.store_mall_directory, () => Navigator.pushNamed(context, '/shopping_points'),),
                buildCategoryButton("Hospedaje", Icons.room_service, ()=> Navigator.pushNamed(context, '/hotel_points'),),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Configuraciones'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/favorites');
          if (index == 1) Navigator.pushNamed(context, '/config');
          if (index == 2) Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }
}