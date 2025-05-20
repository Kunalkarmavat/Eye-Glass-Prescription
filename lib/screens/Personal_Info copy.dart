import 'package:eye_glass/providers/prescription_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  List<String> lensTypes = [
    'Distance',
    'Reading',
    'Computer',
    'Trifocal',
    'Bifocal',
    'Progressive',
  ];
  String? selectedLensType;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      controller.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrescriptionProvider>(context);
    Color myColor = const Color.fromARGB(255, 242, 242, 253);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: myColor,
      appBar: AppBar(
        backgroundColor: myColor,
        foregroundColor: Colors.black,
        title: const Text(
          'PERSONAL INFORMATION.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 100),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Prescription Name"),
              const SizedBox(height: 14),
              TextField(
                controller: provider.prescriptionNameController,
                decoration: _inputDecoration('eg. Kunal Karmavat'),
              ),
              const SizedBox(height: 14),
              const Text("Doctor's Name"),
              const SizedBox(height: 14),
              TextField(
                controller: provider.doctorNameController,
                decoration: _inputDecoration('eg. Dr. Sharma'),
              ),
            ]),
          ),
          _dateBox("Prescription Date", provider.prescriptionDateController),
          _dateBox("Expiry Date", provider.expiryDateController),
          _dateBox("Revisit Date", provider.revisitDateController),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 24),
              const Text("Lens Type",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: lensTypes.map((type) {
                  final bool isSelected = selectedLensType == type;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLensType = type;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 18),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromRGBO(72, 76, 224, 1)
                            : Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ]),
          ),
        ],
      ),
      bottomSheet: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/form2');
            print(provider.prescriptionNameController.text);
          },
          child: Container(
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(72, 76, 224, 1),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Save & Next',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: myColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateBox(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 18),
        Text(label),
        const SizedBox(height: 14),
        TextField(
          readOnly: true,
          controller: controller,
          onTap: () => _selectDate(context, controller),
          decoration: InputDecoration(
            hintText: 'Select Date',
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ]),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
