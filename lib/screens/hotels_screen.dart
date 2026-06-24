import 'package:flutter/material.dart';
import '../models/flight.dart';
import '../data/travel_mock.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  final _destCtrl = TextEditingController(text: 'Madrid');
  DateTime _checkIn = DateTime.now().add(const Duration(days: 14));
  DateTime _checkOut = DateTime.now().add(const Duration(days: 18));
  int _guests = 2;
  bool _searched = false;
  bool _loading = false;
  int _minStars = 0;

  int get _nights => _checkOut.difference(_checkIn).inDays;

  Future<void> _search() async {
    FocusScope.of(context).unfocus();
    setState(() { _loading = true; });
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() { _loading = false; _searched = true; });
  }

  Future<void> _pickDate(bool isCheckIn) async {
    final initial = isCheckIn ? _checkIn : _checkOut;
    final first = isCheckIn ? DateTime.now() : _checkIn.add(const Duration(days: 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkIn = picked;
          if (_checkOut.isBefore(_checkIn.add(const Duration(days: 1)))) {
            _checkOut = _checkIn.add(const Duration(days: 1));
          }
        } else {
          _checkOut = picked;
        }
      });
    }
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Buscar Hoteles'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchForm(),
          if (_loading)
            const Expanded(
                child: Center(child: CircularProgressIndicator(color: Colors.deepOrange)))
          else if (_searched)
            Expanded(child: _HotelResults(hotels: mockHotels, nights: _nights, minStars: _minStars, onFilterChanged: (v) => setState(() => _minStars = v)))
          else
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🏨', style: TextStyle(fontSize: 56)),
                    SizedBox(height: 16),
                    Text('Ingresá tu destino y buscá hoteles',
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchForm() {
    return Container(
      color: Colors.deepOrange,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Column(
        children: [
          TextField(
            controller: _destCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Ciudad o destino',
              hintStyle: TextStyle(color: Colors.white60),
              prefixIcon: Icon(Icons.location_on, color: Colors.white70),
              enabledBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _pickDate(true),
                  child: _DateChip(label: 'Check-in', date: _fmt(_checkIn)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => _pickDate(false),
                  child: _DateChip(label: 'Check-out', date: _fmt(_checkOut)),
                ),
              ),
              const SizedBox(width: 10),
              _GuestSelector(
                count: _guests,
                onDecrease: () { if (_guests > 1) setState(() => _guests--); },
                onIncrease: () { if (_guests < 8) setState(() => _guests++); },
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: Text('Buscar en ${_destCtrl.text}', style: const TextStyle(fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _search,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String label, date;
  const _DateChip({required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10)),
          Text(date, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _GuestSelector extends StatelessWidget {
  final int count;
  final VoidCallback onDecrease, onIncrease;
  const _GuestSelector({required this.count, required this.onDecrease, required this.onIncrease});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.white, size: 16),
            onPressed: onDecrease,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
          Text('$count 👤', style: const TextStyle(color: Colors.white, fontSize: 12)),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 16),
            onPressed: onIncrease,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _HotelResults extends StatelessWidget {
  final List<Hotel> hotels;
  final int nights;
  final int minStars;
  final ValueChanged<int> onFilterChanged;
  const _HotelResults({required this.hotels, required this.nights, required this.minStars, required this.onFilterChanged});

  List<Hotel> get _filtered =>
      hotels.where((h) => h.stars >= minStars).toList()
        ..sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StarFilter(selected: minStars, onChanged: onFilterChanged),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Row(
            children: [
              Text('${_filtered.length} hoteles · $nights noches',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filtered.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _HotelCard(hotel: _filtered[i], nights: nights),
            ),
          ),
        ),
      ],
    );
  }
}

class _StarFilter extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  const _StarFilter({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        children: [
          _chip('Todos', 0, selected, onChanged),
          _chip('2+★', 2, selected, onChanged),
          _chip('3+★', 3, selected, onChanged),
          _chip('4+★', 4, selected, onChanged),
          _chip('5★', 5, selected, onChanged),
        ],
      ),
    );
  }

  Widget _chip(String label, int value, int selected, ValueChanged<int> onChanged) {
    final isSelected = value == selected;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: Colors.deepOrange,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        onSelected: (_) => onChanged(value),
      ),
    );
  }
}

class _HotelCard extends StatelessWidget {
  final Hotel hotel;
  final int nights;
  const _HotelCard({required this.hotel, required this.nights});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Center(
              child: Text(hotel.emoji, style: const TextStyle(fontSize: 52)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(hotel.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    Row(
                      children: List.generate(
                        hotel.stars,
                        (_) => const Icon(Icons.star, size: 13, color: Colors.amber),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 13, color: Colors.grey),
                    Text(hotel.location,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, size: 13, color: Colors.amber),
                    Text('${hotel.rating} (${hotel.reviews})',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: hotel.amenities
                      .take(4)
                      .map((a) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Text(a, style: const TextStyle(fontSize: 11)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${hotel.pricePerNight.toStringAsFixed(0)}/noche',
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange),
                        ),
                        Text(
                          'Total $nights noches: \$${(hotel.pricePerNight * nights).toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${hotel.name} reservado!'),
                            backgroundColor: Colors.deepOrange,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: const Text('Reservar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
