import 'dart:collection';

import 'package:eye_glass/models/prescription.dart';
import 'package:eye_glass/services/prescription_service.dart';
import 'package:flutter/material.dart';

// class PrescriptionProvider extends ChangeNotifier {
//   final TextEditingController prescriptionNameController =
//       TextEditingController();
//   final TextEditingController doctorNameController = TextEditingController();
//   final TextEditingController prescriptionDateController =
//       TextEditingController();
//   final TextEditingController expiryDateController = TextEditingController();
//   final TextEditingController revisitDateController = TextEditingController();

//   String _storedText = "";

//   String get storedText => _storedText;

//   void getInput() {
//     _storedText = prescriptionDateController.text;
//     notifyListeners(); // notify listeners after updating value
//   }

// final Map<String, dynamic> data = {};
// }

class PrescriptionProvider extends ChangeNotifier {
  final _prescriptionService = PrescriptionService();

  List<Prescription> _prescriptions = [];
  Prescription _prescription = Prescription(
    patientName: '',
    doctorName: '',
    date: '',
    expiryDate: '',
    revisitDate: '',
    lensType: null,
    lens: null,
  );
  List<Prescription> _filteredPrescriptions = [];

  UnmodifiableListView<Prescription> get prescriptions =>
      UnmodifiableListView(_prescriptions);

  set prescription(Prescription prescription) {
    _prescription = prescription;
  }

  Future<void> getAllPrescriptions() async {
    final response = await _prescriptionService.getAll();
    _prescriptions = response;
    _filteredPrescriptions = List.from(_prescriptions);
    notifyListeners();
  }

  Future<void> addPrescription(Prescription prescription) async {
    // _prescription.lens = lensInfo;
    _prescriptions.add(_prescription);
    await _prescriptionService.add(prescription);
    notifyListeners();
  }

  List<Prescription> get filteredPrescriptions => _filteredPrescriptions;

  void filterData(String keyword) {
    keyword = keyword.toLowerCase();

    _filteredPrescriptions = _prescriptions
        .where((item) => item.patientName!.toLowerCase().contains(keyword))
        .toList();

    notifyListeners();
  }

  Prescription getPrescription() {
    return _prescriptions.last;
  }
}
