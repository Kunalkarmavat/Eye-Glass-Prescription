import 'package:eye_glass/models/lens.dart';
import 'package:eye_glass/models/prescription.dart';
import 'package:eye_glass/providers/prescription_provider.dart';
import 'package:eye_glass/screens/final_summary_screen.dart';
import 'package:eye_glass/widgets/lens_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LensInfoScreen extends StatefulWidget {
  const LensInfoScreen({super.key, required this.prescription});

  final Prescription prescription;

  @override
  State<LensInfoScreen> createState() => _LensInfoScreenState();
}

class _LensInfoScreenState extends State<LensInfoScreen> {
  final TextEditingController _rightAxis = TextEditingController();
  final TextEditingController _leftAxis = TextEditingController();
  final TextEditingController _rightSphere = TextEditingController();
  final TextEditingController _leftSphere = TextEditingController();
  final TextEditingController _rightCylinder = TextEditingController();
  final TextEditingController _leftCylinder = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _isPrism = 'Yes';
  String _isPd = 'Yes';

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionProvider =
        Provider.of<PrescriptionProvider>(context, listen: false);

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
          InputTable(
            rightSphere: _rightSphere,
            leftSphere: _leftSphere,
            rightCylinder: _rightCylinder,
            leftCylinder: _leftCylinder,
            rightAxis: _rightAxis,
            leftAxis: _leftAxis,
          ),
          const SizedBox(height: 24),
          const SizedBox(height: 12),
          LensSelector(
            label: 'Prisms',
            onSelectionChange: (String? value) =>
                setState(() => _isPrism = value!),
            selectedOption: _isPrism,
          ),
          LensSelector(
            label: 'Pupillary Distance (PD)',
            onSelectionChange: (String? value) =>
                setState(() => _isPd = value!),
            selectedOption: _isPd,
          ),
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
            final lens = Lens(
              prism: _isPrism,
              pupillaryDistance: _isPd,
              rightSphere: double.tryParse(_rightSphere.text)!,
              rightCylinder: double.tryParse(_rightCylinder.text)!,
              rightAxis: double.tryParse(_rightAxis.text)!,
              leftSphere: double.tryParse(_leftSphere.text)!,
              leftCylinder: double.tryParse(_leftCylinder.text)!,
              leftAxis: double.tryParse(_leftAxis.text)!,
            );
            widget.prescription.lens = lens;
            prescriptionProvider.addPrescription(widget.prescription);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FinalSummaryScreen(
                  prescription: widget.prescription,
                ),
              ),
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
}

const TextStyle _buttonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

class InputTable extends StatelessWidget {
  const InputTable(
      {super.key,
      required this.rightSphere,
      required this.leftAxis,
      required this.leftCylinder,
      required this.leftSphere,
      required this.rightAxis,
      required this.rightCylinder});

  final TextEditingController rightSphere;
  final TextEditingController leftSphere;
  final TextEditingController rightCylinder;
  final TextEditingController leftCylinder;
  final TextEditingController rightAxis;
  final TextEditingController leftAxis;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(80),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      // border: TableBorder.all(color: Colors.grey),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        const TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(''),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Right'))),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Left'))),
          ],
        ),
        TableRow(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Sphere'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: '0.00'),
                controller: rightSphere,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: '0.00'),
                controller: leftSphere,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Cylinder'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: '0.00'),
                controller: rightCylinder,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: '0.00'),
                controller: leftCylinder,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Axis'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: '0'),
                controller: rightAxis,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: '0'),
                controller: leftAxis,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
