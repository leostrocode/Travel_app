import 'package:flutter/material.dart';

void main() => runApp(TravelApp());

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tu Perfil'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileCard(
              title: 'Viajero Sencillo',
              description: 'Opciones económicas y prácticas.',
              color: Colors.blue[200]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(profile: 'sencillo'),
                  ),
                );
              },
            ),
            ProfileCard(
              title: 'Buen Paladar',
              description: 'Excelente calidad/precio en destinos accesibles.',
              color: Colors.orange[200]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(profile: 'buen_paladar'),
                  ),
                );
              },
            ),
            ProfileCard(
              title: 'Viajero Premium',
              description: 'Lo mejor del lujo y confort.',
              color: Colors.purple[200]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(profile: 'premium'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title, description;
  final Color color;
  final VoidCallback onTap;

  ProfileCard({
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String profile;
  HomeScreen({required this.profile});

  @override
  Widget build(BuildContext context) {
    String greeting = '';
    if (profile == 'sencillo') {
      greeting = 'Bienvenido, Viajero Sencillo';
    } else if (profile == 'buen_paladar') {
      greeting = '¡Hola, Viajero de Buen Paladar!';
    } else if (profile == 'premium') {
      greeting = '¡Saludos, Viajero Premium!';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              greeting,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('¡Explora los mejores destinos para ti!'),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Aquí irá la acción para buscar destinos
              },
              child: Text('Buscar Destinos'),
            ),
          ],
        ),
      ),
    );
  }
}