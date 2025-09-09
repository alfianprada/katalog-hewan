import 'package:flutter/material.dart';
import '../models/pet.dart';
import 'detail_page.dart';
import 'favorit_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomePage({super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Pet> pets = [
    Pet(
      name: "Milo",
      type: "Kucing",
      image: "assets/images/kucing.jpg",
      characteristic: "Lucu, aktif, dan suka bermain.",
      careTips: "Beri makan 2 kali sehari dan sediakan tempat tidur yang nyaman.",
    ),
    Pet(
      name: "Rocky",
      type: "Anjing",
      image: "assets/images/anjing.jpg",
      characteristic: "Setia, ramah, dan suka berlari.",
      careTips: "Ajak jalan-jalan setiap pagi dan perhatikan kesehatannya.",
    ),
    Pet(
      name: "Luna",
      type: "Kelinci",
      image: "assets/images/kelinci.jpg",
      characteristic: "Tenang, manja, dan suka sayuran.",
      careTips: "Sediakan kandang yang bersih dan makanan bergizi.",
    ),
    Pet(
      name: "Nemo",
      type: "Ikan",
      image: "assets/images/ikan.jpg",
      characteristic: "Berwarna cerah dan mudah dirawat.",
      careTips: "Ganti air akuarium setiap minggu dan beri pakan secukupnya.",
    ),
    Pet(
      name: "Coco",
      type: "Burung",
      image: "assets/images/burung.jpg",
      characteristic: "Ceria, bisa menirukan suara, dan aktif.",
      careTips: "Beri biji-bijian dan latih agar jinak.",
    ),
  ];

  List<Pet> filteredPets = [];
  final Set<Pet> favoritPets = {};

  @override
  void initState() {
    super.initState();
    filteredPets = pets;
  }

  void _searchPet(String query) {
    setState(() {
      filteredPets = pets
          .where((pet) => pet.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleFavorit(Pet pet) {
    setState(() {
      if (favoritPets.contains(pet)) {
        favoritPets.remove(pet);
      } else {
        favoritPets.add(pet);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Hewan Peliharaan"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: widget.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritPage(favoritPets: favoritPets.toList()),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _searchPet,
              decoration: InputDecoration(
                hintText: "Cari hewan berdasarkan nama...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredPets.length,
              itemBuilder: (context, index) {
                final pet = filteredPets[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => DetailPage(
                          pet: pet,
                          isFavorite: favoritPets.contains(pet),
                          onFavoriteToggle: () => _toggleFavorit(pet),
                        ),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Hero(
                        tag: pet.name,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(pet.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pet.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                pet.type,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: IconButton(
                            key: ValueKey(favoritPets.contains(pet)),
                            icon: Icon(
                              favoritPets.contains(pet)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () => _toggleFavorit(pet),
                          ),
                        ),
                      ),
                    ],
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
