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
          : ListView.builder(
              itemCount: favoritPets.length,
              itemBuilder: (context, index) {
                final pet = favoritPets[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        pet.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      pet.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(pet.type),
                  ),
                );
              },
            ),
    );
  }
}
