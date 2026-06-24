import 'package:flutter/material.dart';
import '../models/flight.dart';
import '../data/travel_mock.dart';

class FlightsScreen extends StatefulWidget {
  final String? initialDestination;
  const FlightsScreen({super.key, this.initialDestination});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  final _originCtrl = TextEditingController(text: 'Buenos Aires (EZE)');
  late final _destCtrl = TextEditingController(
    text: widget.initialDestination ?? 'Madrid (MAD)',
  );
  DateTime _departureDate = DateTime.now().add(const Duration(days: 14));
  int _passengers = 1;
  bool _searched = false;
  bool _loading = false;

  void _swapCities() {
    final tmp = _originCtrl.text;
    _originCtrl.text = _destCtrl.text;
    _destCtrl.text = tmp;
  }

  Future<void> _search() async {
    FocusScope.of(context).unfocus();
    setState(() { _loading = true; });
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() { _loading = false; _searched = true; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Buscar Vuelos'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _SearchForm(
            originCtrl: _originCtrl,
            destCtrl: _destCtrl,
            departureDate: _departureDate,
            passengers: _passengers,
            onSwap: _swapCities,
            onDatePick: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _departureDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => _departureDate = picked);
            },
            onPassengersChanged: (v) => setState(() => _passengers = v),
            onSearch: _search,
          ),
          if (_loading)
            const Expanded(child: Center(child: CircularProgressIndicator(color: Colors.indigo)))
          else if (_searched)
            Expanded(child: _FlightResults(flights: mockFlights, passengers: _passengers))
          else
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('✈️', style: TextStyle(fontSize: 56)),
                    SizedBox(height: 16),
                    Text('Ingresá tu destino y buscá vuelos',
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchForm extends StatelessWidget {
  final TextEditingController originCtrl, destCtrl;
  final DateTime departureDate;
  final int passengers;
  final VoidCallback onSwap, onDatePick, onSearch;
  final ValueChanged<int> onPassengersChanged;

  const _SearchForm({
    required this.originCtrl,
    required this.destCtrl,
    required this.departureDate,
    required this.passengers,
    required this.onSwap,
    required this.onDatePick,
    required this.onPassengersChanged,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${departureDate.day.toString().padLeft(2, '0')}/${departureDate.month.toString().padLeft(2, '0')}/${departureDate.year}';

    return Container(
      color: Colors.indigo,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _CityField(controller: originCtrl, hint: 'Origen')),
              IconButton(
                icon: const Icon(Icons.swap_horiz, color: Colors.white),
                onPressed: onSwap,
              ),
              Expanded(child: _CityField(controller: destCtrl, hint: 'Destino')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onDatePick,
                  child: _InfoChip(
                    icon: Icons.calendar_today,
                    label: dateStr,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _PassengerSelector(
                count: passengers,
                onDecrease: () { if (passengers > 1) onPassengersChanged(passengers - 1); },
                onIncrease: () { if (passengers < 9) onPassengersChanged(passengers + 1); },
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('Buscar vuelos', style: TextStyle(fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: onSearch,
            ),
          ),
        ],
      ),
    );
  }
}

class _CityField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const _CityField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}

class _PassengerSelector extends StatelessWidget {
  final int count;
  final VoidCallback onDecrease, onIncrease;
  const _PassengerSelector(
      {required this.count, required this.onDecrease, required this.onIncrease});

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
            icon: const Icon(Icons.remove, color: Colors.white, size: 18),
            onPressed: onDecrease,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '$count pax',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 18),
            onPressed: onIncrease,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _FlightResults extends StatelessWidget {
  final List<Flight> flights;
  final int passengers;
  const _FlightResults({required this.flights, required this.passengers});

  @override
  Widget build(BuildContext context) {
    final sorted = List<Flight>.from(flights)..sort((a, b) => a.price.compareTo(b.price));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            '${sorted.length} vuelos encontrados',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: sorted.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _FlightCard(flight: sorted[i], passengers: passengers),
            ),
          ),
        ),
      ],
    );
  }
}

class _FlightCard extends StatelessWidget {
  final Flight flight;
  final int passengers;
  const _FlightCard({required this.flight, required this.passengers});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Text(flight.airlineLogo, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(flight.airline,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(flight.flightClass,
                          style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${(flight.price * passengers).toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                    Text(
                      passengers > 1 ? 'total $passengers pax' : 'por persona',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _TimeBlock(time: flight.departureTime, label: flight.origin.split(' ').last),
                Expanded(
                  child: Column(
                    children: [
                      Text(flight.duration,
                          style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Divider(color: Colors.grey[400]),
                          if (flight.stops == 0)
                            const Icon(Icons.flight, size: 16, color: Colors.indigo)
                          else
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${flight.stops} escala',
                                style: TextStyle(fontSize: 10, color: Colors.orange.shade800),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                _TimeBlock(time: flight.arrivalTime, label: flight.destination.split(' ').last),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.indigo,
                  side: const BorderSide(color: Colors.indigo),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Vuelo ${flight.airline} seleccionado'),
                      backgroundColor: Colors.indigo,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('Seleccionar vuelo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeBlock extends StatelessWidget {
  final String time, label;
  const _TimeBlock({required this.time, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(time,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }
}
