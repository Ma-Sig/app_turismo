import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class HotelPointsScreen extends StatefulWidget {
  @override
  State<HotelPointsScreen> createState() => _HotelPointsScreenState();
}

class _HotelPointsScreenState extends State<HotelPointsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> allHotels = [
    {
      'name': 'Hotel Oro Verde',
      'address': 'Av. Ordóñez Lasso s/n y Felipe II',
      'image': 'assets/hotel.jpg',
    },
    {
      'name': 'Hotel Santa Lucía',
      'address': 'Pres. Borrero 8-44 y Sucre',
      'image': '',
    },
    {
      'name': 'Hotel Carvallo',
      'address': 'Gran Colombia 9-52 y Benigno Malo',
      'image': '',
    },
    {
      'name': 'Hotel Victoria',
      'address': 'Calle Larga 6-93 y Borrero',
      'image': '',
    },
  ];

  List<Map<String, String>> filteredHotels = [];

  @override
  void initState() {
    super.initState();
    filteredHotels = allHotels;
    _searchController.addListener(_filterHotels);
  }

  void _filterHotels() {
    setState(() {
      filteredHotels = allHotels
          .where((hotel) => hotel['name']!
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
        backgroundColor: Colors.blue[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Hoteles', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue[700],
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '¿Qué hotel buscas?',
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
                Icon(Icons.tune, color: Colors.white),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: filteredHotels.length,
              itemBuilder: (context, index) {
                final hotel = filteredHotels[index];
                final isFirst = allHotels.indexOf(hotel) == 0;
                final isFavorite = FavoritesManager.isFavorite(hotel);

                return GestureDetector(
                  onTap: () {
                    if (isFirst) Navigator.pushNamed(context, '/hotel');
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: isFirst ? Colors.white : Colors.blue[700],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isFirst
                          ? [BoxShadow(color: Colors.black12, blurRadius: 4)]
                          : [],
                    ),
                    child: isFirst
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (hotel['image'] != null && hotel['image']!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.asset(
                                    hotel['image']!,
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
                                    Text(
                                      hotel['name']!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.blue[900]),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      hotel['address']!,
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(
                                            5,
                                            (i) => Icon(Icons.star,
                                                color: Colors.yellow, size: 18),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text('4,9',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        IconButton(
                                          icon: Icon(
                                            isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (isFavorite) {
                                                FavoritesManager.remove(hotel);
                                              } else {
                                                FavoritesManager.add(hotel);
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
                              child: Icon(Icons.hotel,
                                  size: 32, color: Colors.black54),
                            ),
                            title: Text(hotel['name']!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(hotel['address']!,
                                style: TextStyle(color: Colors.white70)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: List.generate(
                                    5,
                                    (i) => Icon(Icons.star,
                                        color: Colors.yellow, size: 18),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text('4,8',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
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
