import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../data/mock_data.dart';
import '../widgets/destination_card.dart';
import 'destination_detail_screen.dart';

class DestinationsScreen extends StatefulWidget {
  final TravelerProfile profile;
  const DestinationsScreen({super.key, required this.profile});

  @override
  State<DestinationsScreen> createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  String _selectedCategory = 'Todos';
  String _searchQuery = '';

  List<String> get _categories {
    final cats = getDestinationsForProfile(widget.profile)
        .map((d) => d.category)
        .toSet()
        .toList()
      ..sort();
    return ['Todos', ...cats];
  }

  List<Destination> get _filtered {
    return getDestinationsForProfile(widget.profile).where((d) {
      final matchCat = _selectedCategory == 'Todos' || d.category == _selectedCategory;
      final matchSearch = _searchQuery.isEmpty ||
          d.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.country.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCat && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Destinos'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _SearchBar(onChanged: (v) => setState(() => _searchQuery = v)),
          _CategoryChips(
            categories: _categories,
            selected: _selectedCategory,
            onSelect: (c) => setState(() => _selectedCategory = c),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Text('No hay destinos para este filtro.',
                        style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filtered.length,
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DestinationCard(
                        destination: _filtered[i],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DestinationDetailScreen(
                              destination: _filtered[i],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Buscar destino o país...',
          prefixIcon: const Icon(Icons.search, color: Colors.teal),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelect;

  const _CategoryChips(
      {required this.categories, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (_, i) {
          final cat = categories[i];
          final isSelected = cat == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              selectedColor: Colors.teal,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (_) => onSelect(cat),
            ),
          );
        },
      ),
    );
  }
}
