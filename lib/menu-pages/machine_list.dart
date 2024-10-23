import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../product_details_page.dart';
import 'package:provider/provider.dart';

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

// Auth state management
class AuthState extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}

class MachineList extends StatefulWidget {
  const MachineList({super.key});

  @override
  State<MachineList> createState() => _MachineListState();
}

class _MachineListState extends State<MachineList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'name'; // 'name' or 'year'

  final Map<String, List<Machine>> _categories = {
    'Chocolate Processing': [
      Machine(
          name: 'LEGEND',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(
          name: 'TRUFFLE',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(
          name: 'MASTER',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Coating Lines': [
      Machine(
          name: 'COATING LINE 20',
          productionYear: '2020',
          imageUrl: '/api/placeholder/100/100'),
      Machine(
          name: 'COATING LINE 40',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
      Machine(
          name: 'COATING LINE 60',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
    ],
    'Tempering Machines': [
      Machine(
          name: 'TOP EX',
          productionYear: '2023',
          imageUrl: '/api/placeholder/100/100'),
      Machine(
          name: 'PLUS EX',
          productionYear: '2022',
          imageUrl: '/api/placeholder/100/100'),
      Machine(
          name: 'TWIN EX',
          productionYear: '2021',
          imageUrl: '/api/placeholder/100/100'),
    ],
  };

  List<String> getFilteredCategories() {
    if (_searchQuery.isEmpty) return _categories.keys.toList();

    return _categories.entries
        .where((entry) => entry.value.any((machine) {
              if (_selectedFilter == 'name') {
                return machine.name
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase());
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
            return machine.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
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
          title: Text('Add New ${isCategory ? 'Category' : 'Machine'}'),
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
                  Text(isCategory ? 'Add Category' : 'Add Machine'),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    onChanged: (value) => newItemName = value,
                  ),
                  if (!isCategory)
                    TextField(
                      decoration:
                          const InputDecoration(labelText: 'Production Year'),
                      onChanged: (value) => newItemYear = value,
                    ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (isCategory) {
                  if (newItemName.isNotEmpty) {
                    setState(() {
                      _categories[newItemName] = [];
                    });
                  }
                } else {
                  // Add machine to first category (simplified)
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
        appBar: AppBar(
          title: Text(
            'Machine List',
            style: GoogleFonts.dosis(
              textStyle: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF25344D),
        floatingActionButton: Consumer<AuthState>(
          builder: (context, authState, child) {
            return authState.isAuthenticated
                ? FloatingActionButton(
                    onPressed: () => _showAddDialog(context),
                    backgroundColor: const Color(0xFF304A78),
                    child: const Icon(Icons.add),
                  )
                : const SizedBox.shrink();
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.white54),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.white54),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'name',
                        groupValue: _selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            _selectedFilter = value!;
                          });
                        },
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.grey;
                          }
                          return Colors.white;
                        }),
                      ),
                      const Text('Name', style: TextStyle(color: Colors.white)),
                      Radio<String>(
                        value: 'year',
                        groupValue: _selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            _selectedFilter = value!;
                          });
                        },
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.grey;
                          }
                          return Colors.white;
                        }),
                      ),
                      const Text('Year', style: TextStyle(color: Colors.white)),
                    ],
                  ),
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

  Widget _buildExpandableCategory(BuildContext context, String category) {
    return Card(
      color: const Color(0xFF1E2937),
      margin: const EdgeInsets.only(bottom: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Colors.white24,
          width: 1.0,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          category,
          style: GoogleFonts.dosis(
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        children: getFilteredMachines(category).map((machine) {
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
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            subtitle: Text(
              'Production Year: ${machine.productionYear}',
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: Consumer<AuthState>(
              builder: (context, authState, child) {
                if (authState.isAuthenticated) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white70),
                        onPressed: () {
                          // Implement edit functionality
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white70),
                        onPressed: () {
                          // Implement delete functionality
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    productName: machine.name,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
