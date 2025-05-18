import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/prescription_Provider.dart';

class FinalSummary extends StatelessWidget {
  const FinalSummary({super.key});

  @override
  Widget build(BuildContext context) {
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
                _buildSummaryRow("Prescription Name", provider.prescriptionNameController.text),
                _buildSummaryRow("Doctor Name", provider.doctorNameController.text),
                _buildSummaryRow("Prescription Date", provider.prescriptionDateController.text),
                _buildSummaryRow("Expiry Date", provider.expiryDateController.text),
                _buildSummaryRow("Revisit Date", provider.revisitDateController.text),
                const SizedBox(height: 20),
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
