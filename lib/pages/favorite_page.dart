import 'package:flutter/material.dart';
import '../models/pet.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  final List<Pet> favorites;
  final Function(Pet) onToggleFavorite;

  const FavoritePage({Key? key, required this.favorites, required this.onToggleFavorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          "Belum ada hewan favorit 😿",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final pet = favorites[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(pet: pet, onToggleFavorite: onToggleFavorite),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    pet.image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(pet.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(pet.type, style: const TextStyle(color: Colors.grey)),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => onToggleFavorite(pet),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
