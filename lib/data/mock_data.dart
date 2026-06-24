import '../models/destination.dart';

const List<Destination> allDestinations = [
  // --- Viajero Sencillo ---
  Destination(
    id: 'd1',
    name: 'Medellín',
    country: 'Colombia',
    description:
        'La ciudad de la eterna primavera. Hostales acogedores, metro accesible y una vibrante escena cultural.',
    emoji: '🌸',
    pricePerNight: 18,
    rating: 4.5,
    highlights: ['Comunas urbanas', 'Metro + cable', 'Feria de las Flores', 'Parque Arví'],
    profiles: [TravelerProfile.sencillo],
    category: 'Ciudad',
  ),
  Destination(
    id: 'd2',
    name: 'Ciudad de México',
    country: 'México',
    description:
        'Metrópolis llena de historia, museos gratuitos, tacos de 1 dólar y transporte público excelente.',
    emoji: '🌮',
    pricePerNight: 22,
    rating: 4.6,
    highlights: ['Zócalo', 'Teotihuacán', 'Tacos en mercados', 'Chapultepec gratis'],
    profiles: [TravelerProfile.sencillo],
    category: 'Ciudad',
  ),
  Destination(
    id: 'd3',
    name: 'Chiang Mai',
    country: 'Tailandia',
    description:
        'El paraíso del mochilero en Asia. Templos budistas, mercados nocturnos y hostales desde 8 USD.',
    emoji: '🛕',
    pricePerNight: 12,
    rating: 4.7,
    highlights: ['Doi Suthep', 'Mercado nocturno', 'Clases de cocina', 'Santuario de elefantes'],
    profiles: [TravelerProfile.sencillo, TravelerProfile.buenPaladar],
    category: 'Naturaleza',
  ),
  Destination(
    id: 'd4',
    name: 'Lisboa',
    country: 'Portugal',
    description:
        'Una de las capitales más baratas de Europa Occidental. Tranvías, pasteles de nata y fados nocturnos.',
    emoji: '🚃',
    pricePerNight: 35,
    rating: 4.8,
    highlights: ['Alfama', 'Pastéis de Belém', 'Mirador', 'Fado en vivo'],
    profiles: [TravelerProfile.sencillo, TravelerProfile.buenPaladar],
    category: 'Ciudad',
  ),

  // --- Buen Paladar ---
  Destination(
    id: 'd5',
    name: 'San Sebastián',
    country: 'España',
    description:
        'Capital mundial de la gastronomía. Pintxos de autor, playas hermosas y arquitectura elegante.',
    emoji: '🦞',
    pricePerNight: 90,
    rating: 4.9,
    highlights: ['Pintxos en el Parte Vieja', 'Playa La Concha', 'Mercado de La Bretxa', 'Sidrerías'],
    profiles: [TravelerProfile.buenPaladar],
    category: 'Gastronomía',
  ),
  Destination(
    id: 'd6',
    name: 'Kyoto',
    country: 'Japón',
    description:
        'Tradición japonesa con experiencias culinarias únicas. Kaiseki, templos y geishas en Gion.',
    emoji: '⛩️',
    pricePerNight: 110,
    rating: 4.9,
    highlights: ['Fushimi Inari', 'Kaiseki auténtico', 'Distrito Gion', 'Arashiyama'],
    profiles: [TravelerProfile.buenPaladar, TravelerProfile.premium],
    category: 'Cultura',
  ),
  Destination(
    id: 'd7',
    name: 'Buenos Aires',
    country: 'Argentina',
    description:
        'El París de Sudamérica. Asados legendarios, vino Malbec, tango y barrios con carácter.',
    emoji: '💃',
    pricePerNight: 60,
    rating: 4.6,
    highlights: ['Parrilla en Palermo', 'Espectáculo de Tango', 'Recoleta', 'Vino Malbec'],
    profiles: [TravelerProfile.buenPaladar],
    category: 'Gastronomía',
  ),
  Destination(
    id: 'd8',
    name: 'Provenza',
    country: 'Francia',
    description:
        'Campos de lavanda, mercados provenzales, rosé frío y pueblos medievales de cuento.',
    emoji: '💜',
    pricePerNight: 120,
    rating: 4.7,
    highlights: ['Campos de lavanda', 'Mercado de Aix', 'Rosé local', 'Gorges du Verdon'],
    profiles: [TravelerProfile.buenPaladar, TravelerProfile.premium],
    category: 'Naturaleza',
  ),

  // --- Viajero Premium ---
  Destination(
    id: 'd9',
    name: 'Maldivas',
    country: 'Maldivas',
    description:
        'Villas sobre el agua, arrecifes de coral privados y cenas bajo las estrellas en el Índico.',
    emoji: '🏝️',
    pricePerNight: 600,
    rating: 5.0,
    highlights: ['Villa sobre el agua', 'Buceo privado', 'Spa de lujo', 'Cena en el océano'],
    profiles: [TravelerProfile.premium],
    category: 'Playa',
  ),
  Destination(
    id: 'd10',
    name: 'Dubái',
    country: 'Emiratos Árabes',
    description:
        'Rascacielos imposibles, hoteles 7 estrellas, cenas en las alturas y experiencias de lujo sin igual.',
    emoji: '🏙️',
    pricePerNight: 400,
    rating: 4.8,
    highlights: ['Burj Khalifa', 'Brunch del viernes', 'Desert Safari VIP', 'Dubai Mall'],
    profiles: [TravelerProfile.premium],
    category: 'Ciudad',
  ),
  Destination(
    id: 'd11',
    name: 'Santorini',
    country: 'Grecia',
    description:
        'Suites con piscina privada sobre la caldera, atardeceres en Oia y vino local volcánico.',
    emoji: '🌅',
    pricePerNight: 350,
    rating: 4.9,
    highlights: ['Oia al atardecer', 'Suite con piscina', 'Catamarán privado', 'Vino Assyrtiko'],
    profiles: [TravelerProfile.premium],
    category: 'Playa',
  ),
  Destination(
    id: 'd12',
    name: 'Patagonia',
    country: 'Argentina / Chile',
    description:
        'El fin del mundo con lodges de lujo, trekking exclusivo en Torres del Paine y cielos estrellados únicos.',
    emoji: '🏔️',
    pricePerNight: 280,
    rating: 4.9,
    highlights: ['Torres del Paine', 'Lodge de lujo', 'Glaciar Perito Moreno', 'Trekking privado'],
    profiles: [TravelerProfile.premium, TravelerProfile.buenPaladar],
    category: 'Naturaleza',
  ),
];

List<Destination> getDestinationsForProfile(TravelerProfile profile) {
  return allDestinations.where((d) => d.profiles.contains(profile)).toList();
}

TravelerProfile profileFromString(String profile) {
  switch (profile) {
    case 'buen_paladar':
      return TravelerProfile.buenPaladar;
    case 'premium':
      return TravelerProfile.premium;
    default:
      return TravelerProfile.sencillo;
  }
}
