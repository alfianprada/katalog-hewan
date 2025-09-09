import 'package:flutter/material.dart';
import '../models/pet.dart';

class DetailPage extends StatelessWidget {
  final Pet pet;
  final Function(Pet) onToggleFavorite;

  const DetailPage({Key? key, required this.pet, required this.onToggleFavorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(
              pet.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: pet.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => onToggleFavorite(pet),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              pet.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text("Jenis: ${pet.type}", style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  const Divider(height: 30),
                  const Text("Karakteristik:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(pet.characteristic, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  const Text("Tips Perawatan:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(pet.careTips, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
