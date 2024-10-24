import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Components/header.dart';
import 'product_details_page.dart';

class Machine {
  final String name;
  final String productionYear;
  final String imageUrl;

  Machine({
    required this.name,
    required this.productionYear,
    required this.imageUrl,
  });
}

class AuthState extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'name';

  final Map<String, List<Machine>> _categories = {
    'Temperaggio': [
      Machine(name: 'LEGEND',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'SELMI ONE',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'COLOR EX',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'PLUS EX',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'FUTURA EX',
          productionYear: '2024',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'TOP EX',
          productionYear: '2020',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'CENTO',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Ricopertura': [
      Machine(name: 'TRUFFLE',
          productionYear: '2020',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'R200 LEGEND',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'RS200',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'AUTOMATIC TRUFFLE',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'Rt400 PLUS',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'R600',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Modellaggio Cioccolato': [
      Machine(name: 'MOULD LOADER 175',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'MOULDING LINE 275',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'SMODELLATORE AUTOMATICO',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'INJECTION PLATE',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'FILLER PRALINE',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'FILLER VASI - FILLER VASI AUTOMATICA',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'GALILEO',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'STAMPi',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Chocopaint': [
      Machine(name: 'CHOCOPAINT',
          productionYear: '2024',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Tunnel di Raffreddamento e Ricopertura': [
      Machine(name: 'SPIDER',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'SPIDER MAXNEW',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'TUNNEL 200/250 MM',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'TUNNEL 300/400 MM',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'TUNNEL 600 MM',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'DROPS SYSTEM',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'One Shot Tuttuno': [
      Machine(name: 'ONE SHOT TUTTUNO 4',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'ONE SHOT TUTTUNO 9',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'CARICATORE DI STAMPI',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'CHARGER 175/275',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'VIBRA',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'DEPOSITOR',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'SPINNER EXIT 175/275',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'One Shot Tuttuno ICE': [
      Machine(name: 'ONE SHOT TUTTUNO ICE',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Cluster': [
      Machine(name: 'CLUSTER',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'CLUSTER TEGLIA',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Confettatrici Bassine': [
      Machine(name: 'COMFIT',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'COMFIT MAXI',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'SPRAYSYSTEM',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Scioglitori e Miscelatori': [
      Machine(name: 'TANK 200',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'TANK 400',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Estrusori': [
      Machine(name: 'CHOCOFORM',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'CHOCOLINER',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'EXTRUDER',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Raffinatrici a Sfere': [
      Machine(name: 'MICRON 25',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'MICRON 50',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Tostatrici': [
      Machine(name: 'TOSTATRICE ROASTER 106',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'TOSTATRICE ROASTER 120',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'BeanToBar': [
      Machine(name: 'WINNOWERS',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'GRINDER PLUS',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'CONCA 100',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'CONCA 200-400',
          productionYear: '2024',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'VAGLIO',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'LavorazioneFruttaSecca': [
      Machine(name: 'GRINDER PLUS',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'GRAIN',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'VAGLIO',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'FontaneDiCioccolato': [
      Machine(name: 'MACCHIA',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'MACCHIA TEMPERANTE',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(name: 'FONTANA A MURO',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
  };

  List<String> getFilteredCategories() {
    if (_searchQuery.isEmpty) return _categories.keys.toList();

    return _categories.entries
        .where((entry) =>
        entry.value.any((machine) {
          if (_selectedFilter == 'name') {
            return machine.name.toLowerCase().contains(
                _searchQuery.toLowerCase());
          } else {
            return machine.productionYear.contains(_searchQuery);
          }
        }))
        .map((e) => e.key)
        .toList();
  }

  List<Machine> getFilteredMachines(String category) {
    if (_searchQuery.isEmpty) return _categories[category] ?? [];

    return _categories[category]?.where((machine) {
      if (_selectedFilter == 'name') {
        return machine.name.toLowerCase().contains(_searchQuery.toLowerCase());
      } else {
        return machine.productionYear.contains(_searchQuery);
      }
    }).toList() ??
        [];
  }

  void _showAddDialog(BuildContext context) {
    String newItemName = '';
    String newItemYear = '';
    bool isCategory = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF25344D),
          title: Text(
            'Add New ${isCategory ? 'Category' : 'Machine'}',
            style: const TextStyle(color: Colors.white),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: isCategory,
                    onChanged: (bool value) {
                      setState(() {
                        isCategory = value;
                      });
                    },
                  ),
                  Text(
                    isCategory ? 'Add Category' : 'Add Machine',
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) => newItemName = value,
                  ),
                  if (!isCategory)
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Production Year',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) => newItemYear = value,
                    ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text(
                  'Cancel', style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Add', style: TextStyle(color: Colors.white70)),
              onPressed: () {
                if (isCategory) {
                  if (newItemName.isNotEmpty) {
                    setState(() {
                      _categories[newItemName] = [];
                    });
                  }
                } else {
                  if (newItemName.isNotEmpty && newItemYear.isNotEmpty) {
                    setState(() {
                      _categories.entries.first.value.add(
                        Machine(
                          name: newItemName,
                          productionYear: newItemYear,
                          imageUrl: '/api/placeholder/100/100',
                        ),
                      );
                    });
                  }
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthState(),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Consumer<AuthState>(
          builder: (context, authState, child) {
            return authState.isAuthenticated
                ? FloatingActionButton(
              onPressed: () => _showAddDialog(context),
              backgroundColor: const Color(0xFFCFB587), // Inverted color
              child: const Icon(Icons.add),
            )
                : const SizedBox.shrink();
          },
        ),
        body: Column(
          children: [
            Header(
              onMenuPressed: () {

              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildSearchField(),
                  _buildFilterRadios(),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: getFilteredCategories().map((category) {
                      return _buildExpandableCategory(context, category);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      style: const TextStyle(color: Color(0xFF25344D)), // Inverted text color
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: const TextStyle(color: Color(0xFF25344D)),
        prefixIcon: const Icon(Icons.search, color: Color(0xFF25344D)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFF25344D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFF25344D)),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  Widget _buildFilterRadios() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilterRadio('name', 'Name'),
        _buildFilterRadio('year', 'Year'),
      ],
    );
  }

  Widget _buildFilterRadio(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _selectedFilter,
          onChanged: (value) {
            setState(() {
              _selectedFilter = value!;
            });
          },
          fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                  ? Colors.grey
                  : const Color(0xFF25344D);
            },
          ),
        ),
        Text(label, style: TextStyle(color: Color(0xFF25344D))),
      ],
    );
  }

  Widget _buildExpandableCategory(BuildContext context, String category) {
    return Card(
      color: Colors.white, // Inverted card color
      margin: const EdgeInsets.only(bottom: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Color(0xFF25344D).withOpacity(0.24), // Inverted border color
          width: 1.0,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          category,
          style: GoogleFonts.dosis(
            textStyle: TextStyle(
              fontSize: 20,
              color: Color(0xFF25344D), // Inverted text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        children: getFilteredMachines(category).map((machine) {
          return _buildMachineListTile(context, machine);
        }).toList(),
      ),
    );
  }

  Widget _buildMachineListTile(BuildContext context, Machine machine) {
    return ListTile(
      leading: Image.network(
        machine.imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(
        machine.name,
        style: GoogleFonts.dosis(
          textStyle: TextStyle(
            fontSize: 18,
            color: Color(0xFF25344D), // Inverted text color
          ),
        ),
      ),
      subtitle: Text(
        'Production Year: ${machine.productionYear}',
        style: TextStyle(color: Color(0xFF25344D).withOpacity(
            0.7)), // Inverted subtitle color
      ),
      trailing: Consumer<AuthState>(
        builder: (context, authState, child) {
          if (authState.isAuthenticated) {
            return _buildMachineActionButtons(machine);
          }
          return const SizedBox.shrink();
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsPage(
                  productName: machine.name,
                ),
          ),
        );
      },
    );
  }

  Widget _buildMachineActionButtons(Machine machine) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Color(0xFF25344D).withOpacity(0.7)),
          // Inverted icon color
          onPressed: () {
            // Implement edit functionality
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Color(0xFF25344D).withOpacity(0.7)),
          // Inverted icon color
          onPressed: () {
            // Implement delete functionality
          },
        ),
      ],
    );
  }
}
