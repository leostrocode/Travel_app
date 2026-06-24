import 'package:flutter/material.dart';
import 'models/destination.dart';
import 'data/mock_data.dart';
import 'screens/destinations_screen.dart';
import 'screens/destination_detail_screen.dart';
import 'widgets/destination_card.dart';

void main() => runApp(const TravelApp());

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

// ──────────────────────────────────────────────
// Profile selection screen
// ──────────────────────────────────────────────

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade700,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿Cómo viajás?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Elegí tu perfil para ver destinos personalizados.',
                style: TextStyle(color: Colors.teal.shade100, fontSize: 15),
              ),
              const SizedBox(height: 40),
              _ProfileCard(
                emoji: '🎒',
                title: 'Viajero Sencillo',
                description: 'Opciones económicas y prácticas.',
                color: Colors.blue.shade400,
                onTap: () => _navigate(context, 'sencillo'),
              ),
              const SizedBox(height: 16),
              _ProfileCard(
                emoji: '🍷',
                title: 'Buen Paladar',
                description: 'Calidad/precio en destinos accesibles.',
                color: Colors.orange.shade400,
                onTap: () => _navigate(context, 'buen_paladar'),
              ),
              const SizedBox(height: 16),
              _ProfileCard(
                emoji: '✨',
                title: 'Viajero Premium',
                description: 'Lo mejor del lujo y confort.',
                color: Colors.purple.shade400,
                onTap: () => _navigate(context, 'premium'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, String profile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(profile: profileFromString(profile)),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String emoji, title, description;
  final Color color;
  final VoidCallback onTap;

  const _ProfileCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: TextStyle(color: Colors.teal.shade100, fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Home screen (after profile selection)
// ──────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  final TravelerProfile profile;
  const HomeScreen({super.key, required this.profile});

  String get _greeting {
    switch (profile) {
      case TravelerProfile.sencillo:
        return 'Bienvenido, Viajero Sencillo 🎒';
      case TravelerProfile.buenPaladar:
        return '¡Hola, Viajero de Buen Paladar 🍷!';
      case TravelerProfile.premium:
        return '¡Saludos, Viajero Premium ✨!';
    }
  }

  String get _subtitle {
    switch (profile) {
      case TravelerProfile.sencillo:
        return 'Destinos increíbles al mejor precio.';
      case TravelerProfile.buenPaladar:
        return 'Calidad, sabor y experiencias únicas.';
      case TravelerProfile.premium:
        return 'Lujo, exclusividad y confort total.';
    }
  }

  List<Destination> get _featured {
    return getDestinationsForProfile(profile).take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroBanner(greeting: _greeting, subtitle: _subtitle),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Destacados para ti',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DestinationsScreen(profile: profile),
                      ),
                    ),
                    child: const Text('Ver todos', style: TextStyle(color: Colors.teal)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ..._featured.map(
              (d) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: DestinationCard(
                  destination: d,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DestinationDetailScreen(destination: d),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar Destinos', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DestinationsScreen(profile: profile),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final String greeting, subtitle;
  const _HeroBanner({required this.greeting, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }
}
