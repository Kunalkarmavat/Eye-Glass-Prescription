import 'package:eye_glass/widgets/lens_input_field.dart';
import 'package:flutter/material.dart';

class LensInput extends StatelessWidget {
  const LensInput({
    super.key,
    required this.eye,
    required this.controller,
    this.label1 = '',
    this.label2 = '',
  });

  final String eye;
  final String label1;
  final String label2;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Text(eye, style: _sectionTitleStyle),
        ),
        LensInputField(label: label1, controller: controller),
        LensInputField(label: label1, controller: controller),
        // LensInputField(label: label2, controller: controller),
      ],
    );
  }
}

const TextStyle _sectionTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
