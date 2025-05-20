import 'dart:convert';

import 'package:eye_glass/models/lens.dart';
import 'package:eye_glass/models/prescription.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final Uri uri = Uri.https(
    dotenv.env['FIREBASE_URI']!, "${dotenv.env['DATABASE_NAME']}.json");

class PrescriptionService {
  Future<List<Prescription>> getAll() async {
    final List<Prescription> fetchedItems = [];
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200 && response.body != 'null') {
        final Map<String, dynamic> resData = json.decode(response.body);

        for (final item in resData.entries) {
          fetchedItems.add(
            Prescription(
              id: item.key,
              patientName: item.value['patientName'],
              doctorName: item.value['doctorName'],
              date: item.value['date'],
              expiryDate: item.value['expiryDate'],
              revisitDate: item.value['revisitDate'],
              lensType: Prescription.parseLensOption(item.value['lensType']),
              lens: Lens.fromJson(item.value['lens']),
            ),
          );
        }
      }
    } catch (e) {
      print('Error Occurred' + e.toString());
    }
    return fetchedItems;
  }

  Future<void> add(Prescription prescription) async {
    try {
      await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'patientName': prescription.patientName,
          'doctorName': prescription.doctorName,
          'date': prescription.date,
          'expiryDate': prescription.expiryDate,
          'revisitDate': prescription.revisitDate,
          'lensType': prescription.lensType!.name,
          'lens': prescription.lens!.toJson(),
        }),
      );
    } catch (e) {
      print("Error Occured" + e.toString());
    }
  }
}
