import 'package:eye_glass/models/prescription.dart';
// import 'package:eye_glass/providers/prescription_provider.dart';
// import 'package:provider/provider.dart';
import 'package:eye_glass/screens/lens_info_screen.dart';
import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _revisitDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  LensOption? _selectedLensType;

  @override
  void dispose() {
    _patientNameController.dispose();
    _doctorNameController.dispose();
    _dateController.dispose();
    _expiryDateController.dispose();
    _revisitDateController.dispose();
    super.dispose();
  }

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
    // final provider = Provider.of<PrescriptionProvider>(context, listen: false);
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
                controller: _patientNameController,
                decoration: _inputDecoration('eg. Kunal Karmavat'),
              ),
              const SizedBox(height: 14),
              const Text("Doctor's Name"),
              const SizedBox(height: 14),
              TextField(
                controller: _doctorNameController,
                decoration: _inputDecoration('eg. Dr. Sharma'),
              ),
            ]),
          ),
          _dateBox("Prescription Date", _dateController),
          _dateBox("Expiry Date", _expiryDateController),
          _dateBox("Revisit Date", _revisitDateController),
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
                children: LensOption.values.map((lens) {
                  final bool isSelected = _selectedLensType == lens;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLensType = lens;
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
                        lens.name[0].toUpperCase() + lens.name.substring(1),
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
            Prescription prescription = Prescription(
                patientName: _patientNameController.text,
                doctorName: _doctorNameController.text,
                date: _dateController.text,
                expiryDate: _expiryDateController.text,
                revisitDate: _revisitDateController.text,
                lensType: _selectedLensType!,
                lens: null);
            // provider.prescription = Prescription(
            //     patientName: _patientNameController.text,
            //     doctorName: _doctorNameController.text,
            //     date: _dateController.text,
            //     expiryDate: _expiryDateController.text,
            //     revisitDate: _revisitDateController.text,
            //     lensType: _selectedLensType!,
            //     lens: null);
            // Navigator.pushNamed(context, '/form2');
            // print(_patientNameController.text);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LensInfoScreen(
                prescription: prescription,
              ),
            ));
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
