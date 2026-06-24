class Flight {
  final String airline;
  final String airlineLogo;
  final String origin;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final int stops;
  final double price;
  final String flightClass;

  const Flight({
    required this.airline,
    required this.airlineLogo,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.stops,
    required this.price,
    required this.flightClass,
  });
}

class Hotel {
  final String name;
  final String location;
  final String emoji;
  final double rating;
  final int reviews;
  final double pricePerNight;
  final List<String> amenities;
  final int stars;

  const Hotel({
    required this.name,
    required this.location,
    required this.emoji,
    required this.rating,
    required this.reviews,
    required this.pricePerNight,
    required this.amenities,
    required this.stars,
  });
}
