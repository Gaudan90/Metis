import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'carModel.dart';

class CarStorage {
  static const String _key = 'cars';

  static Future<void> saveCars(List<Car> cars) async {
    final prefs = await SharedPreferences.getInstance();
    final carsJson = cars.map((car) => car.toJson()).toList();
    await prefs.setString(_key, jsonEncode(carsJson));
  }

  static Future<List<Car>> loadCars() async {
    final prefs = await SharedPreferences.getInstance();
    final carsString = prefs.getString(_key);
    if (carsString == null) return [];

    final carsJson = jsonDecode(carsString) as List;
    return carsJson
        .map((json) => Car.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
