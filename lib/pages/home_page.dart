import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../widgets/pet_card.dart';
import 'detail_page.dart';
import 'favorit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<Pet> pets = [
    Pet(
      name: "Milo",
      type: "Kucing",
      image: "images/kucing.jpg",
      characteristic: "Lucu, aktif, dan suka bermain.",
      careTips: "Beri makan 2 kali sehari dan sediakan tempat tidur yang nyaman.",
    ),
    Pet(
      name: "Rocky",
      type: "Anjing",
      image: "images/anjing.jpg",
      characteristic: "Setia, ramah, dan suka berlari.",
      careTips: "Ajak jalan-jalan setiap pagi dan perhatikan kesehatannya.",
    ),
    Pet(
      name: "Luna",
      type: "Kelinci",
      image: "images/kelinci.jpg",
      characteristic: "Tenang, manja, dan suka sayuran.",
      careTips: "Sediakan kandang yang bersih dan makanan bergizi.",
    ),
    Pet(
      name: "Nemo",
      type: "Ikan",
      image: "images/ikan.jpg",
      characteristic: "Berwarna cerah dan mudah dirawat.",
      careTips: "Ganti air akuarium setiap minggu dan beri pakan secukupnya.",
    ),
    Pet(
      name: "Coco",
      type: "Burung",
      image: "images/burung.jpg",
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
        elevation: 4,
        actions: [
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
            child: ListView.builder(
              itemCount: filteredPets.length,
              itemBuilder: (context, index) {
                final pet = filteredPets[index];
                return Dismissible(
                  key: Key(pet.name),
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    setState(() {
                      pets.remove(pet);
                      filteredPets.remove(pet);
                      favoritPets.remove(pet);
                    });
                  },
                  child: PetCard(
                    pet: pet,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(pet: pet),
                        ),
                      );
                    },
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
