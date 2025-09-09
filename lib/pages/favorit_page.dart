import 'package:flutter/material.dart';
import '../models/pet.dart';

class FavoritPage extends StatelessWidget {
  final List<Pet> favoritPets;

  const FavoritPage({Key? key, required this.favoritPets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hewan Favorit"),
        backgroundColor: Colors.teal,
      ),
      body: favoritPets.isEmpty
          ? const Center(
              child: Text(
                "Belum ada hewan favorit 🐾",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: favoritPets.length,
              itemBuilder: (context, index) {
                final pet = favoritPets[index];
                return Hero(
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
                );
              },
            ),
    );
  }
}
