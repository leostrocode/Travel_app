enum TravelerProfile { sencillo, buenPaladar, premium }

class Destination {
  final String id;
  final String name;
  final String country;
  final String description;
  final String emoji;
  final double pricePerNight;
  final double rating;
  final List<String> highlights;
  final List<TravelerProfile> profiles;
  final String category;

  const Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.description,
    required this.emoji,
    required this.pricePerNight,
    required this.rating,
    required this.highlights,
    required this.profiles,
    required this.category,
  });

  String get priceLabel {
    if (pricePerNight < 30) return '\$';
    if (pricePerNight < 80) return '\$\$';
    if (pricePerNight < 200) return '\$\$\$';
    return '\$\$\$\$';
  }
}
