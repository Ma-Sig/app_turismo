import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class BarPointsScreen extends StatefulWidget {
  @override
  State<BarPointsScreen> createState() => _BarPointsScreenState();
}

class _BarPointsScreenState extends State<BarPointsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> allBars = [
    {
      'name': 'Jodoco Belgian Bistro',
      'address': 'Honorato Vásquez 6-41 y Hermano Miguel',
      'image': 'assets/bar.jpg',
    },
    {
      'name': 'La Cigale',
      'address': 'Luis Cordero y Honorato Vásquez',
      'image': '',
    },
  ];

  List<Map<String, String>> filteredBars = [];

  @override
  void initState() {
    super.initState();
    filteredBars = allBars;
    _searchController.addListener(_filterBars);
  }

  void _filterBars() {
    setState(() {
      filteredBars = allBars
          .where((bar) => bar['name']!
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
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Bares', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '¿Qué bar buscas?',
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
              itemCount: filteredBars.length,
              itemBuilder: (context, index) {
                final bar = filteredBars[index];
                final isFirst = allBars.indexOf(bar) == 0;
                final isFavorite = FavoritesManager.isFavorite(bar);

                return GestureDetector(
                  onTap: () {
                    if (isFirst) Navigator.pushNamed(context, '/bar');
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: isFirst ? Colors.white : Colors.green,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isFirst
                          ? [BoxShadow(color: Colors.black12, blurRadius: 4)]
                          : [],
                    ),
                    child: isFirst
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (bar['image'] != null && bar['image']!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.asset(
                                    bar['image']!,
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
                                    Text(bar['name']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green[900])),
                                    SizedBox(height: 4),
                                    Text(bar['address']!, style: TextStyle(color: Colors.black54, fontSize: 12)),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(5, (i) => Icon(Icons.star, color: Colors.yellow, size: 18)),
                                        ),
                                        SizedBox(width: 8),
                                        Text('4,9', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        IconButton(
                                          icon: Icon(
                                            isFavorite ? Icons.favorite : Icons.favorite_border,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (isFavorite) {
                                                FavoritesManager.remove(bar);
                                              } else {
                                                FavoritesManager.add(bar);
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
                              child: Icon(Icons.local_bar, size: 32, color: Colors.black54),
                            ),
                            title: Text(bar['name']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            subtitle: Text(bar['address']!, style: TextStyle(color: Colors.white70)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: List.generate(5, (i) => Icon(Icons.star, color: Colors.yellow, size: 18)),
                                ),
                                SizedBox(width: 4),
                                Text('4,9', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
