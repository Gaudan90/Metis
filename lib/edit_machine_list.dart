import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../product_details_page.dart';
import '../auth_state.dart';
import '../Data/machine.dart';
import '../Data/machine_list_state.dart';

class EditMachineList extends StatefulWidget {
  const EditMachineList({super.key});

  @override
  State<EditMachineList> createState() => _MachineListState();
}

class _MachineListState extends State<EditMachineList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'name';
  final MachineListState _state = MachineListState();

  List<String> getFilteredCategories() {
    if (_searchQuery.isEmpty) return _state.categories.keys.toList();

    return _state.categories.entries
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
    if (_searchQuery.isEmpty) return _state.categories[category] ?? [];

    return _state.categories[category]?.where((machine) {
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

  void _showDeleteConfirmation(
      BuildContext context, String category, Machine machine) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${machine.name}?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  _state.categories[category]?.remove(machine);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteCategoryConfirmation(BuildContext context, String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete Category'),
          content: Text(
              'Are you sure you want to delete "$category" and all its machines?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  _state.categories.remove(category);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCategoryDialog(BuildContext context, String category) {
    final categoryController = TextEditingController(text: category);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Category Name'),
          content: TextField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                if (categoryController.text.isNotEmpty &&
                    categoryController.text != category) {
                  setState(() {
                    final machines = _state.categories[category];
                    _state.categories.remove(category);
                    _state.categories[categoryController.text] = machines ?? [];
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, String category, Machine machine) {
    final nameController = TextEditingController(text: machine.name);
    final yearController = TextEditingController(text: machine.productionYear);
    final imageController = TextEditingController(text: machine.imageUrl);
    final descriptionController =
    TextEditingController(text: machine.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Machine'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: yearController,
                  decoration:
                  const InputDecoration(labelText: 'Production Year'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      imageController.text = image.path;
                    }
                  },
                  child: const Text('Choose from Gallery'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  final index =
                      _state.categories[category]?.indexOf(machine) ?? -1;
                  if (index != -1) {
                    _state.categories[category]?[index] = Machine(
                      name: nameController.text,
                      productionYear: yearController.text,
                      imageUrl: imageController.text,
                      description: descriptionController.text,
                    );
                  }
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddMachineDialog(BuildContext context, String category) {
    final nameController = TextEditingController();
    final yearController = TextEditingController();
    final imageController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Machine to $category'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: yearController,
                  decoration:
                  const InputDecoration(labelText: 'Production Year'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      imageController.text = image.path;
                    }
                  },
                  child: const Text('Choose from Gallery'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    yearController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  setState(() {
                    _state.categories[category]?.add(
                      Machine(
                        name: nameController.text,
                        productionYear: yearController.text,
                        description: descriptionController.text,
                        imageUrl: imageController.text.isEmpty
                            ? '/api/placeholder/100/100'
                            : imageController.text,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: TextField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (categoryController.text.isNotEmpty) {
                  setState(() {
                    _state.categories[categoryController.text] = [];
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF25344D),
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
      floatingActionButton: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return authProvider.isAuthenticated
              ? SizedBox(
            width: 140,
            height: 48,
            child: FloatingActionButton.extended(
              onPressed: () => _showAddCategoryDialog(context),
              backgroundColor: const Color(0xFF304A78),
              label: const Text(
                "New Category",
                style: TextStyle(color: Colors.white),
              ),
            ),
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
                    return Card(
                      color: Colors.white,
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
                              color: Color(0xFF1E2937),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return authProvider.isAuthenticated
                                ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Color(0xFF1E2937)),
                                  onPressed: () =>
                                      _showEditCategoryDialog(
                                          context, category),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Color(0xFF1E2937)),
                                  onPressed: () =>
                                      _showDeleteCategoryConfirmation(
                                          context, category),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Color(0xFF1E2937)),
                                  onPressed: () => _showAddMachineDialog(
                                      context, category),
                                ),
                                const Icon(Icons.expand_more,
                                    color: Color(0xFF1E2937)),
                              ],
                            )
                                : const Icon(Icons.expand_more,
                                color: Color(0xFF1E2937));
                          },
                        ),
                        children: getFilteredMachines(category).map((machine) {
                          final isLastItem =
                              getFilteredMachines(category).last == machine;
                          return Column(
                            children: [
                              ListTile(
                                leading: Image.network(
                                  machine.imageUrl,
                                  // width: 150,
                                  //height: 150,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  machine.name,
                                  style: GoogleFonts.dosis(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF1E2937),
                                    ),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Production Year: ${machine.productionYear}',
                                      style: const TextStyle(
                                          color: Color(0xFF1E2937)),
                                    ),
                                    Text(
                                      machine.description,
                                      style: const TextStyle(
                                          color: Color(0xFF1E2937)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                trailing: Consumer<AuthProvider>(
                                  builder: (context, authProvider, child) {
                                    if (authProvider.isAuthenticated) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Color(0xFF1E2937)),
                                            onPressed: () => _showEditDialog(
                                                context, category, machine),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Color(0xFF1E2937)),
                                            onPressed: () =>
                                                _showDeleteConfirmation(
                                                    context, category, machine),
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
                              ),
                              if (!isLastItem)
                                const Divider(
                                  height: 1,
                                  thickness: 2,
                                  color: Color(0xFF1E2937),
                                  indent: 16,
                                  endIndent: 16,
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}