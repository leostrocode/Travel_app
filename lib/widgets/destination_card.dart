import 'package:flutter/material.dart';
import '../models/destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;

  const DestinationCard({super.key, required this.destination, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroBox(destination: destination),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          destination.name,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _StarRating(rating: destination.rating),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${destination.country}  ·  ${destination.category}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        destination.priceLabel,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
                        ),
                      ),
                      Text(
                        'desde \$${destination.pricePerNight.toStringAsFixed(0)}/noche',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroBox extends StatelessWidget {
  final Destination destination;
  const _HeroBox({required this.destination});

  Color get _bgColor {
    switch (destination.category) {
      case 'Playa':
        return Colors.cyan.shade100;
      case 'Naturaleza':
        return Colors.green.shade100;
      case 'Gastronomía':
        return Colors.orange.shade100;
      case 'Cultura':
        return Colors.purple.shade100;
      default:
        return Colors.blue.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: _bgColor,
      child: Center(
        child: Text(destination.emoji, style: const TextStyle(fontSize: 64)),
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;
  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, size: 14, color: Colors.amber),
        const SizedBox(width: 2),
        Text(rating.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
