import 'dart:collection';

import 'package:eye_glass/models/lens.dart';
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

  UnmodifiableListView<Prescription> get prescriptions =>
      UnmodifiableListView(_prescriptions);

  set prescription(Prescription prescription) {
    _prescription = prescription;
  }

  Future<void> getAllPrescriptions() async {
    final response = await _prescriptionService.getAll();
    _prescriptions = response;
    print(response);
    notifyListeners();
  }

  Future<void> addPrescription(Lens lensInfo) async {
    _prescription.lens = lensInfo;
    _prescriptions.add(_prescription);
    await _prescriptionService.add(_prescription);
    notifyListeners();
  }

  Prescription getPrescription() {
    return _prescriptions.last;
  }
}
