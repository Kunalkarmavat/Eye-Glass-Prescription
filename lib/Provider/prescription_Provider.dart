import 'package:flutter/material.dart';

class PrescriptionProvider extends ChangeNotifier {

  final TextEditingController prescriptionNameController = TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController prescriptionDateController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController revisitDateController = TextEditingController();

  String _storedText = "";

  String get storedText => _storedText;

  void getInput() {
    _storedText = prescriptionDateController.text;
    notifyListeners(); // notify listeners after updating value
  }

  final Map<String, dynamic> data = {};

  
}
