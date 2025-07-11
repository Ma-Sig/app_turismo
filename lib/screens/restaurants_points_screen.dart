import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class RestaurantPointsScreen extends StatefulWidget {
  @override
  State<RestaurantPointsScreen> createState() => _RestaurantPointsScreenState();
}

class _RestaurantPointsScreenState extends State<RestaurantPointsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> allRestaurants = [
    {
      'name': 'Tiesto’s',
      'address': 'Juan Jaramillo 7-34 y Borrero',
      'image': 'assets/restaurante.jpg',
    },
    {
      'name': 'El Mercado',
      'address': 'Benigno Malo 6-75 y Juan Jaramillo',
      'image': '',
    },
    {
      'name': 'Cuchara Mágica',
      'address': 'Av. Loja y Alfonso Cordero',
      'image': '',
    },
    {
      'name': 'Casa Alonso',
      'address': 'Pres. Córdova 12-30 y Tarqui',
      'image': '',
    },
  ];

  List<Map<String, String>> filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    filteredRestaurants = allRestaurants;
    _searchController.addListener(_filterRestaurants);
  }

  void _filterRestaurants() {
    setState(() {
      filteredRestaurants = allRestaurants
          .where((restaurant) => restaurant['name']!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Restaurantes', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepOrange,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '¿Qué restaurante buscas?',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.tune, color: Colors.black),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                final isFirst = allRestaurants.indexOf(restaurant) == 0;
                final isFavorite = FavoritesManager.isFavorite(restaurant);

                return GestureDetector(
                  onTap: () {
                    if (isFirst) Navigator.pushNamed(context, '/restaurant');
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: isFirst ? Colors.white : Colors.deepOrange,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isFirst ? [BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
                    ),
                    child: isFirst
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (restaurant['image'] != null && restaurant['image']!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.asset(
                                    restaurant['image']!,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(restaurant['name']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepOrange[900])),
                                    SizedBox(height: 4),
                                    Text(restaurant['address']!, style: TextStyle(color: Colors.black54, fontSize: 12)),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(5, (i) => Icon(Icons.star, color: Colors.yellow, size: 18)),
                                        ),
                                        SizedBox(width: 8),
                                        Text('4,8', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        IconButton(
                                          icon: Icon(
                                            isFavorite ? Icons.favorite : Icons.favorite_border,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (isFavorite) {
                                                FavoritesManager.remove(restaurant);
                                              } else {
                                                FavoritesManager.add(restaurant);
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : ListTile(
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.restaurant, size: 32, color: Colors.black54),
                            ),
                            title: Text(restaurant['name']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            subtitle: Text(restaurant['address']!, style: TextStyle(color: Colors.white70)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: List.generate(5, (i) => Icon(Icons.star, color: Colors.yellow, size: 18)),
                                ),
                                SizedBox(width: 4),
                                Text('4,7', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
