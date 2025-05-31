import 'dart:collection';

import 'package:eye_glass/models/prescription.dart';
import 'package:eye_glass/services/prescription_service.dart';
import 'package:flutter/material.dart';

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

  String _searchKeyword = "";

  LensOption? _selectedCategory;

  UnmodifiableListView<Prescription> get prescriptions =>
      UnmodifiableListView(_prescriptions);

  LensOption? get selectedCategory => _selectedCategory;

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
    _prescriptions.add(_prescription);
    await _prescriptionService.add(prescription);
    notifyListeners();
  }

  List<Prescription> get filteredPrescriptions => _filteredPrescriptions;

  void filterData(String keyword) {
    _searchKeyword = keyword;

    _applyFilters();
  }

  void filterByCategory(LensOption? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredPrescriptions = _prescriptions.where((item) {
      final matchesKeyword = item.patientName!
          .toLowerCase()
          .contains(_searchKeyword.toLowerCase());
      final matchesCategory =
          _selectedCategory == null || item.lensType == _selectedCategory;
      return matchesKeyword && matchesCategory;
    }).toList();
    notifyListeners();
  }

  Prescription getPrescription() {
    return _prescriptions.last;
  }
}
