import 'package:flutter/material.dart';
import 'dart:io';
import 'carModel.dart';
import 'car_storage.dart';
import 'add_machine.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars() async {
    final loadedCars = await CarStorage.loadCars();
    setState(() {
      cars = loadedCars;
    });
  }

  Future<void> _addNewCar() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCarScreen()),
    );

    if (result != null && result is Car) {
      setState(() {
        cars.add(result);
      });
      await CarStorage.saveCars(cars);
    }
  }

  Future<void> _editCar(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCarScreen(carToEdit: cars[index]),
      ),
    );

    if (result != null && result is Car) {
      setState(() {
        cars[index] = result;
      });
      await CarStorage.saveCars(cars);
    }
  }

  Future<void> _deleteCar(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm deletion'),
        content: const Text('Are you sure you want to delete this car'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        cars.removeAt(index);
      });
      await CarStorage.saveCars(cars);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('my machine'),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Dismissible(
            key: Key(car.title + DateTime.now().toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => _deleteCar(index),
            child: GestureDetector(
              onTap: () => _editCar(index),
              child: Card(
                margin: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: car.imagePath != null
                          ? Image.file(
                              File(car.imagePath!),
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.car_rental, size: 50),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              car.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Year: ${car.year}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
