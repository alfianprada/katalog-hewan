class Pet {
  final String name;
  final String type;
  final String image;
  final String characteristic;
  final String careTips;
  bool isFavorite;

  Pet({
    required this.name,
    required this.type,
    required this.image,
    required this.characteristic,
    required this.careTips,
    this.isFavorite = false,
  });
}
