import 'package:eye_glass/providers/lens_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LensInfo extends StatefulWidget {
  const LensInfo({super.key});

  @override
  State<LensInfo> createState() => _LensInfoState();
}

class _LensInfoState extends State<LensInfo> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lensInfoProvider = Provider.of<LensProvider>(context);
    Size size = MediaQuery.of(context).size;
    Color myColor = const Color.fromARGB(255, 242, 242, 253);

    return Scaffold(
      backgroundColor: myColor,
      appBar: AppBar(
        title: const Text(
          'LENS INFORMATION.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: myColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPrescriptionRow("Right", "Sphere", "Add"),
          _buildPrescriptionRow("Left", "", ""),
          const SizedBox(height: 24),
          _buildPrescriptionRow("Right", "Cylinder", "Axis"),
          _buildPrescriptionRow("Left", "", ""),
          const SizedBox(height: 12),
          _buildSelection('Prisms', lensInfoProvider),
          _buildSelection('Pupillary Distance (PD)', lensInfoProvider),
          const SizedBox(height: 24),
          const Text(
            "Note",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.125,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 120,
            child: TextField(
              controller: _noteController,
              maxLines: null,
              minLines: 5,
              keyboardType: TextInputType.multiline,
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.top,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Add your note',
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
      bottomSheet: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/summary',
              arguments: {
                'prescriptionName': 'Sample Prescription',
                'doctorName': 'Dr. Smith',
                'prescriptionDate': '2024-04-08',
                'expiryDate': '2025-04-08',
                'revisitDate': '2024-10-08',
                'lensType': lensInfoProvider.selectedLensType ?? 'Not selected',
              },
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(72, 76, 224, 1),
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('Continue', style: _buttonTextStyle),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrescriptionRow(String eye, String label1, String label2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 26),
          child: Text(eye, style: _sectionTitleStyle),
        ),
        _buildNarrowTextField(label: label1),
        _buildNarrowTextField(label: label2),
      ],
    );
  }

  Widget _buildSelection(String name, LensProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: _sectionTitleStyle),
        Row(
          children: [
            Radio(
              value: "Yes",
              onChanged: (value) {
                // provider.setSelectedPrisms(value as String?);
              },
              groupValue: '',
            ),
            const Text("Yes", style: _fieldLabelStyle),
            const SizedBox(width: 12),
            Radio(
              value: "No",
              onChanged: (value) {
                // provider.setSelectedPrisms(value as String?);
              },
              groupValue: '',
            ),
            const Text("No", style: _fieldLabelStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildNarrowTextField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: _fieldLabelStyle),
        const SizedBox(height: 12),
        SizedBox(
          width: 140,
          height: 50,
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: 'Enter number',
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

const TextStyle _sectionTitleStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

const TextStyle _fieldLabelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

const TextStyle _buttonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
