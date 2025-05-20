import 'package:eye_glass/models/prescription.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eye_glass/providers/prescription_provider.dart';

class FinalSummaryScreen extends StatelessWidget {
  const FinalSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Prescription prescription =
        context.read<PrescriptionProvider>().getPrescription();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Summary'),
        backgroundColor: const Color.fromARGB(255, 242, 242, 253),
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color.fromARGB(255, 242, 242, 253),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<PrescriptionProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow(
                    "Prescription Name", prescription.patientName!),
                _buildSummaryRow("Doctor Name", prescription.doctorName!),
                _buildSummaryRow("Prescription Date", prescription.date!),
                _buildSummaryRow("Expiry Date", prescription.expiryDate!),
                _buildSummaryRow("Revisit Date", prescription.revisitDate!),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Direction"),
                    Text("Sphere"),
                    Text("Cylinder"),
                    Text("Axis"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Direction"),
                    Text(prescription.lens!.rightSphere.toString()),
                    Text(prescription.lens!.rightCylinder.toString()),
                    // Text(prescription.lens!.rightAxis.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Direction"),
                    Text(prescription.lens!.leftSphere.toString()),
                    Text(prescription.lens!.leftCylinder.toString()),
                    // Text(prescription.lens!.leftAxis.toString()),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
                    },
                    child: const Text("Go to home"))
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
