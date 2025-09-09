import 'package:flutter/material.dart';
import 'models/pet.dart';
import 'pages/home_page.dart';
import 'pages/favorite_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

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

  void toggleFavorite(Pet pet) {
    setState(() {
      pet.isFavorite = !pet.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritePets = pets.where((pet) => pet.isFavorite).toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        body: _currentIndex == 0
            ? HomePage(pets: pets, onToggleFavorite: toggleFavorite)
            : FavoritePage(favorites: favoritePets, onToggleFavorite: toggleFavorite),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Hewan"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
          ],
        ),
      ),
    );
  }
}
