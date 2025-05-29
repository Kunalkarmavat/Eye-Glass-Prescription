import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eye_glass/models/prescription.dart';
import 'package:eye_glass/providers/prescription_provider.dart';

class FinalSummaryScreen extends StatelessWidget {
  const FinalSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Prescription prescription =
        context.read<PrescriptionProvider>().getPrescription();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Icon(Icons.description),
          SizedBox(width: 16),
          Icon(Icons.share),
          SizedBox(width: 16),
          Icon(Icons.delete),
          SizedBox(width: 16),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Consumer<PrescriptionProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Lens Information"),
                _buildInfoRow("Prescription Name", prescription.patientName!),
                _buildInfoRow("Expiry Date", prescription.expiryDate!),
                _buildInfoRow("Visited Date", prescription.date!),
                _buildInfoRow("Revisit Date", prescription.revisitDate!),
                const SizedBox(height: 16),
                _sectionTitle("Lens Information"),
                const SizedBox(height: 10),
                _buildLensTable(prescription),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C4CE8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
                    },
                    child: const Text(
                      "Got Back To Home",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF4C4CE8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildLensTable(Prescription prescription) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Direction", textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sphere", textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Cylinder", textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Axis", textAlign: TextAlign.center),
            ),
          ],
        ),
        TableRow(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Right", textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(prescription.lens!.rightSphere.toString(),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(prescription.lens!.rightCylinder.toString(),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(prescription.lens!.rightAxis.toString(),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        TableRow(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Left", textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(prescription.lens!.leftSphere.toString(),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(prescription.lens!.leftCylinder.toString(),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(prescription.lens!.leftAxis.toString(),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ],
    );
  }
}
