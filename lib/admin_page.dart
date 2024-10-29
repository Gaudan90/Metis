import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Components/header.dart';
import 'product_details_page.dart';
import '../Data/machine.dart';
import '../Data/machine_list_state.dart';

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
  final MachineListState _machineListState = MachineListState();

  List<String> getFilteredCategories() {
    if (_searchQuery.isEmpty) return _machineListState.categories.keys.toList();

    return _machineListState.categories.entries
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
    if (_searchQuery.isEmpty) return _machineListState.categories[category] ?? [];

    return _machineListState.categories[category]?.where((machine) {
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
    String newItemDescription = '';
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
                  if (!isCategory) ...[
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
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) => newItemDescription = value,
                    ),
                  ],
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Add', style: TextStyle(color: Colors.white70)),
              onPressed: () {
                if (isCategory) {
                  if (newItemName.isNotEmpty) {
                    setState(() {
                      _machineListState.categories[newItemName] = [];
                    });
                  }
                } else {
                  if (newItemName.isNotEmpty && newItemYear.isNotEmpty) {
                    setState(() {
                      _machineListState.categories.entries.first.value.add(
                        Machine(
                          name: newItemName,
                          productionYear: newItemYear,
                          imageUrl: '/api/placeholder/100/100',
                          description: newItemDescription,
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
              backgroundColor: const Color(0xFFCFB587),
              child: const Icon(Icons.add),
            )
                : const SizedBox.shrink();
          },
        ),
        body: Column(
          children: [
            Header(
              onMenuPressed: () {
                // Implement menu functionality
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
      style: const TextStyle(color: Color(0xFF25344D)),
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
        Text(label, style: const TextStyle(color: Color(0xFF25344D))),
      ],
    );
  }

  Widget _buildExpandableCategory(BuildContext context, String category) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: const Color(0xFF25344D).withOpacity(0.24),
          width: 1.0,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          category,
          style: GoogleFonts.dosis(
            textStyle: const TextStyle(
              fontSize: 20,
              color: Color(0xFF25344D),
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
          textStyle: const TextStyle(
            fontSize: 18,
            color: Color(0xFF25344D),
          ),
        ),
      ),
      subtitle: Text(
        'Production Year: ${machine.productionYear}',
        style: TextStyle(color: const Color(0xFF25344D).withOpacity(0.7)),
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
            builder: (context) => ProductDetailsPage(
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
          icon: Icon(Icons.edit, color: const Color(0xFF25344D).withOpacity(0.7)),
          onPressed: () {
            // Implement edit functionality
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, color: const Color(0xFF25344D).withOpacity(0.7)),
          onPressed: () {
            // Implement delete functionality
          },
        ),
      ],
    );
  }
}