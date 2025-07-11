import 'package:flutter/material.dart';
import '../models/favorites_manager.dart';

class ShoppingPointsScreen extends StatefulWidget {
  @override
  State<ShoppingPointsScreen> createState() => _ShoppingPointsScreenState();
}

class _ShoppingPointsScreenState extends State<ShoppingPointsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> allMalls = [
    {
      'name': 'Mall del Río',
      'address': 'Av. Felipe II y Autopista Cuenca-Azogues',
      'image': 'assets/mall.jpg',
    },
    {
      'name': 'Mall Monay Shopping',
      'address': 'Av. González Suárez y De Las Américas',
      'image': '',
    },
    {
      'name': 'Coral Centro',
      'address': 'Av. De Las Américas y Turuhuayco',
      'image': '',
    },
    {
      'name': 'Batan Shopping',
      'address': 'Av. Remigio Crespo y Paucarbamba',
      'image': '',
    },
  ];

  List<Map<String, String>> filteredMalls = [];

  @override
  void initState() {
    super.initState();
    filteredMalls = allMalls;
    _searchController.addListener(_filterMalls);
  }

  void _filterMalls() {
    setState(() {
      filteredMalls = allMalls
          .where((mall) =>
              mall['name']!
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
        title: Text('Centros Comerciales', style: TextStyle(color: Colors.black)),
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
                      hintText: '¿Qué mall buscas?',
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
              itemCount: filteredMalls.length,
              itemBuilder: (context, index) {
                final mall = filteredMalls[index];
                final isFirst = allMalls.indexOf(mall) == 0;
                final isFavorite = FavoritesManager.isFavorite(mall);

                return GestureDetector(
                  onTap: () {
                    if (isFirst) Navigator.pushNamed(context, '/mall');
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: isFirst ? Colors.white : Colors.green,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow:
                          isFirst ? [BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
                    ),
                    child: isFirst
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (mall['image'] != null && mall['image']!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.asset(
                                    mall['image']!,
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
                                    Text(mall['name']!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.green[900])),
                                    SizedBox(height: 4),
                                    Text(mall['address']!,
                                        style: TextStyle(
                                            color: Colors.black54, fontSize: 12)),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(
                                              5,
                                              (i) => Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18)),
                                        ),
                                        SizedBox(width: 8),
                                        Text('4,7',
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
                                                FavoritesManager.remove(mall);
                                              } else {
                                                FavoritesManager.add(mall);
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
                              child: Icon(Icons.shopping_bag,
                                  size: 32, color: Colors.black54),
                            ),
                            title: Text(mall['name']!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(mall['address']!,
                                style: TextStyle(color: Colors.white70)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: List.generate(
                                      5,
                                      (i) => Icon(Icons.star,
                                          color: Colors.yellow, size: 18)),
                                ),
                                SizedBox(width: 4),
                                Text('4,6',
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
