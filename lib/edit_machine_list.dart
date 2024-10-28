import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Machine {
  String name;
  String productionYear;
  String imageUrl;
  String description;

  Machine({
    required this.name,
    required this.productionYear,
    required this.imageUrl,
    this.description = '',
  });
}

class EditMachineList extends StatefulWidget {
  final Map<String, List<Machine>> initialCategories;

  const EditMachineList({
    Key? key,
    required this.initialCategories,
  }) : super(key: key);

  @override
  State<EditMachineList> createState() => _EditAdminPageState();
}

class _EditAdminPageState extends State<EditMachineList> {
  late Map<String, List<Machine>> categories;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'name';

  @override
  void initState() {
    super.initState();
    // Create a deep copy of the initial categories
    categories = Map.fromEntries(
      widget.initialCategories.entries.map(
            (entry) => MapEntry(
          entry.key,
          List.from(entry.value),
        ),
      ),
    );
  }

  List<String> getFilteredCategories() {
    if (_searchQuery.isEmpty) return categories.keys.toList();

    return categories.entries
        .where((entry) => entry.value.any((machine) {
      if (_selectedFilter == 'name') {
        return machine.name.toLowerCase().contains(_searchQuery.toLowerCase());
      } else {
        return machine.productionYear.contains(_searchQuery);
      }
    }))
        .map((e) => e.key)
        .toList();
  }

  List<Machine> getFilteredMachines(String category) {
    if (_searchQuery.isEmpty) return categories[category] ?? [];

    return categories[category]?.where((machine) {
      if (_selectedFilter == 'name') {
        return machine.name.toLowerCase().contains(_searchQuery.toLowerCase());
      } else {
        return machine.productionYear.contains(_searchQuery);
      }
    }).toList() ??
        [];
  }

  void _showAddCategoryDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF25344D),
        title: const Text('Add Category', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Category Name',
            labelStyle: TextStyle(color: Colors.white70),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white54),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  categories[controller.text] = [];
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  void _showAddMachineDialog(String category) {
    final nameController = TextEditingController();
    final yearController = TextEditingController();
    final imageController = TextEditingController(text: '/api/placeholder/100/100');
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF25344D),
        title: Text('Add Machine to $category',
            style: const TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: yearController,
                decoration: const InputDecoration(
                  labelText: 'Production Year',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && yearController.text.isNotEmpty) {
                setState(() {
                  categories[category]?.add(
                    Machine(
                      name: nameController.text,
                      productionYear: yearController.text,
                      imageUrl: imageController.text,
                      description: descriptionController.text,
                    ),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  void _showEditMachineDialog(String category, Machine machine) {
    final nameController = TextEditingController(text: machine.name);
    final yearController = TextEditingController(text: machine.productionYear);
    final descriptionController = TextEditingController(text: machine.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF25344D),
        title: const Text('Edit Machine', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: yearController,
                decoration: const InputDecoration(
                  labelText: 'Production Year',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && yearController.text.isNotEmpty) {
                setState(() {
                  final index = categories[category]?.indexOf(machine) ?? -1;
                  if (index != -1) {
                    machine.name = nameController.text;
                    machine.productionYear = yearController.text;
                    machine.description = descriptionController.text;
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  void _deleteMachine(String category, Machine machine) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF25344D),
        title: const Text('Delete Machine', style: TextStyle(color: Colors.white)),
        content: Text('Are you sure you want to delete ${machine.name}?',
            style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                categories[category]?.remove(machine);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF25344D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF25344D),
        title: Text(
          'Edit Machines',
          style: GoogleFonts.dosis(
            textStyle: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCategoryDialog,
        backgroundColor: const Color(0xFFCFB587),
        label: const Text('Add Category'),
        icon: const Icon(Icons.add),
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
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
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
                    Row(
                      children: [
                        Radio<String>(
                          value: 'name',
                          groupValue: _selectedFilter,
                          onChanged: (value) {
                            setState(() {
                              _selectedFilter = value!;
                            });
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Colors.white;
                            },
                          ),
                        ),
                        const Text('Name', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'year',
                          groupValue: _selectedFilter,
                          onChanged: (value) {
                            setState(() {
                              _selectedFilter = value!;
                            });
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Colors.white;
                            },
                          ),
                        ),
                        const Text('Year', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredCategories().length,
              itemBuilder: (context, index) {
                final category = getFilteredCategories()[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ExpansionTile(
                    title: Text(
                      category,
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _showAddMachineDialog(category),
                        ),
                        const Icon(Icons.expand_more),
                      ],
                    ),
                    children: getFilteredMachines(category).map((machine) {
                      return ListTile(
                        leading: Image.network(
                          machine.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(machine.name),
                        subtitle: Text('Year: ${machine.productionYear}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showEditMachineDialog(category, machine),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteMachine(category, machine),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}