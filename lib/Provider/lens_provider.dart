import 'package:flutter/material.dart';

class LensProvider extends ChangeNotifier {
  String? selectedPrism;
  String? pupillaryDistance;
  String? selectedLensType;
  Map<String, String> prescriptionData = {};

  void setPrism(String value) {
    selectedPrism = value;
    notifyListeners();
  }

  void setPD(String value) {
    pupillaryDistance = value;
    notifyListeners();
  }

  void setLensType(String value) {
    selectedLensType = value;
    notifyListeners();
  }

  void updatePrescription(String key, String value) {
    prescriptionData[key] = value;
    notifyListeners();
  }

  void reset() {
    selectedPrism = null;
    pupillaryDistance = null;
    selectedLensType = null;
    prescriptionData.clear();
    notifyListeners();
  }
}
