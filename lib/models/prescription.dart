import 'package:eye_glass/models/lens.dart';
// import 'package:uuid/uuid.dart';

// const uuid = Uuid();

enum LensOption { distance, computer, trifocal, bifocal, progressive }

class Prescription {
  Prescription({
    this.id,
    this.patientName,
    this.doctorName,
    this.date,
    this.expiryDate,
    this.revisitDate,
    this.lensType,
    this.lens,
  });
  // : id = uuid.v4();

  final String? id;
  final String? patientName;
  final String? doctorName;
  final String? date;
  final String? expiryDate;
  final String? revisitDate;
  LensOption? lensType;
  Lens? lens;

  static LensOption parseLensOption(String value) {
    return LensOption.values.firstWhere(
      (e) => e.name == value,
      orElse: () => LensOption.computer,
    );
  }
}
