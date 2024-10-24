import '../Data/machine.dart';

class MachineListState {
  final Map<String, List<Machine>> categories = {
    'Tempering': [
      Machine(name: 'LEGEND',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'A high-performance tempering machine for chocolate.'),
      Machine(name: 'SELMI ONE',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Versatile chocolate tempering solution for various production needs.'),
      Machine(name: 'COLOR EX',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Advanced tempering machine with color mixing capabilities.'),
      Machine(name: 'PLUS EX',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Upgraded tempering technology for consistent results.'),
      Machine(name: 'FUTURA EX',
          productionYear: '2024',
          imageUrl: '/api/placeholder/100/100',
          description: 'Future-oriented tempering machine designed for high efficiency.'),
      Machine(name: 'TOP EX',
          productionYear: '2020',
          imageUrl: '/api/placeholder/100/100',
          description: 'Top-tier tempering machine for professional chocolatiers.'),
      Machine(name: 'CENTO',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Precision tempering for high-quality chocolate production.'),
    ],
    'Coating': [
      Machine(name: 'TRUFFLE',
          productionYear: '2020',
          imageUrl: '/api/placeholder/100/100',
          description: 'Machine for coating truffles and other confections.'),
      Machine(name: 'R200 LEGEND',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Reliable coating machine for various chocolate products.'),
      Machine(name: 'RS200',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Specialized machine for even coating applications.'),
      Machine(name: 'AUTOMATIC TRUFFLE',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Fully automatic truffle coating machine for efficiency.'),
      Machine(name: 'Rt400 PLUS',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Enhanced coating technology for superior finish.'),
      Machine(name: 'R600',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Versatile machine for various chocolate coating needs.'),
    ],
    'Chocolate Molding': [
      Machine(name: 'MOULD LOADER 175',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Efficient loader for chocolate molds.'),
      Machine(name: 'MOULDING LINE 275',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Complete molding line for high production rates.'),
      Machine(name: 'AUTOMATIC MOULDER',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Automatic machine for chocolate molding processes.'),
      Machine(name: 'INJECTION PLATE',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Injection system for precise chocolate filling.'),
      Machine(name: 'PRALINE FILLER',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Filling machine for pralines and chocolates.'),
      Machine(name: 'FILLER VASES - AUTOMATIC FILLER',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Automatic filler for various chocolate molds.'),
      Machine(name: 'GALILEO',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Advanced molding technology for unique designs.'),
      Machine(name: 'STAMPi',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Stamping machine for decorative chocolate designs.'),
    ],
    'ChocoPaint': [
      Machine(name: 'CHOCOPAINT',
          productionYear: '2024',
          imageUrl: '/api/placeholder/100/100',
          description: 'Innovative machine for chocolate decoration and painting.'),
    ],
    'Cooling and Coating Tunnels': [
      Machine(name: 'SPIDER',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Cooling tunnel for efficient chocolate processing.'),
      Machine(name: 'SPIDER MAXNEW',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Upgraded cooling tunnel for maximum efficiency.'),
      Machine(name: 'TUNNEL 200/250 MM',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Cooling tunnel suitable for various production sizes.'),
      Machine(name: 'TUNNEL 300/400 MM',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Medium-sized cooling tunnel for consistent results.'),
      Machine(name: 'TUNNEL 600 MM',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Large cooling tunnel for high-capacity production.'),
      Machine(name: 'DROPS SYSTEM',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'System designed for cooling and coating drops efficiently.'),
    ],
    'One Shot Tuttuno': [
      Machine(name: 'ONE SHOT TUTTUNO 4',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'High-capacity machine for one-shot chocolate production.'),
      Machine(name: 'ONE SHOT TUTTUNO 9',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Advanced one-shot machine for diverse chocolate products.'),
      Machine(name: 'MOULD LOADER',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Efficient loader for one-shot molds.'),
      Machine(name: 'CHARGER 175/275',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Charger designed for one-shot chocolate production lines.'),
      Machine(name: 'VIBRA',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Vibrating system for perfect chocolate filling.'),
      Machine(name: 'DEPOSITOR',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Depositor for precise chocolate placement.'),
      Machine(name: 'SPINNER EXIT 175/275',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Spinner designed for efficient chocolate exiting processes.'),
    ],
    'One Shot Tuttuno ICE': [
      Machine(name: 'ONE SHOT TUTTUNO ICE',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Ice chocolate production machine for unique designs.'),
    ],
    'Cluster': [
      Machine(name: 'CLUSTER',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Machine for producing chocolate clusters efficiently.'),
      Machine(name: 'CLUSTER TEGLIA',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Specialized cluster machine for sheet production.'),
    ],
    'Coating Machines': [
      Machine(name: 'COMFIT',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Machine for coating small confections.'),
      Machine(name: 'COMFIT MAXI',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Larger version for high-volume coating needs.'),
      Machine(name: 'SPRAYSYSTEM',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Spray system for even coating of products.'),
    ],
    'Melted Chocolate and Mixers': [
      Machine(name: 'TANK 200',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Tank for melting and mixing chocolate.'),
      Machine(name: 'TANK 400',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Larger melting tank for high capacity.'),
    ],
    'Extruders': [
      Machine(name: 'CHOCOFORM',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Extruder for shaping chocolate products.'),
      Machine(name: 'CHOCOLINER',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Machine for lining chocolate products.'),
      Machine(name: 'EXTRUDER',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'General-purpose extruder for chocolate.'),
    ],
    'Sphere Refiners': [
      Machine(name: 'MICRON 25',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Refiner for producing fine chocolate textures.'),
      Machine(name: 'MICRON 50',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Advanced refiner for high-quality chocolate.'),
    ],
    'Roasters': [
      Machine(name: 'ROASTER 106',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Roasting machine for chocolate beans.'),
      Machine(name: 'ROASTER 120',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Larger roaster for high-capacity processing.'),
    ],
    'Bean to Bar': [
      Machine(name: 'WINNOWERS',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Machine for separating cocoa beans from shells.'),
      Machine(name: 'GRINDER PLUS',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Advanced grinder for cocoa nibs and chocolate.'),
      Machine(name: 'CONCA 100',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Conching machine for refining chocolate.'),
      Machine(name: 'CONCA 200-400',
          productionYear: '2024',
          imageUrl: '/api/placeholder/100/100',
          description: 'High-capacity conching machine for fine chocolate.'),
      Machine(name: 'VAGLIO',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Sifting machine for quality control of chocolate.'),
    ],
    'Nut Processing': [
      Machine(name: 'GRINDER PLUS',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Machine for grinding nuts and chocolates.'),
      Machine(name: 'GRAIN',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Grinding machine for nut processing.'),
      Machine(name: 'VAGLIO',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Sifting machine for nut products.'),
    ],
    'Chocolate Fountains': [
      Machine(name: 'MACCHIA',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100',
          description: 'Chocolate fountain for decorative serving.'),
      Machine(name: 'MACCHIA TEMPERANTE',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100',
          description: 'Tempering chocolate fountain for optimal flow.'),
      Machine(name: 'WALL FOUNTAIN',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100',
          description: 'Wall-mounted fountain for chocolate displays.'),
    ],
  };
}