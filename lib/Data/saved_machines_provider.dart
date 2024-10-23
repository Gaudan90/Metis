// saved_machines_provider.dart
import 'package:flutter/foundation.dart';

class SavedMachinesProvider extends ChangeNotifier {
  final Set<String> _savedMachines = {};

  Set<String> get savedMachines => _savedMachines;

  bool addMachine(String productName) {
    if (_savedMachines.contains(productName)) {
      return false; // Machine already saved
    }
    _savedMachines.add(productName);
    notifyListeners();
    return true;
  }

  void removeMachine(String productName) {
    _savedMachines.remove(productName);
    notifyListeners();
  }

  bool isMachineSaved(String productName) {
    return _savedMachines.contains(productName);
  }
}
