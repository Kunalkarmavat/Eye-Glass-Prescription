import 'package:flutter/material.dart';

const TextStyle _labelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

class LensSelector extends StatelessWidget {
  const LensSelector(
      {super.key,
      required this.label,
      required this.selectedOption,
      required this.onSelectionChange});

  final String label;
  final String selectedOption;
  final Function(String? value) onSelectionChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: _labelStyle),
        Row(
          children: [
            Radio(
              value: "Yes",
              onChanged: onSelectionChange,
              groupValue: selectedOption,
            ),
            const Text("Yes", style: _labelStyle),
            const SizedBox(width: 12),
            Radio(
              value: "No",
              onChanged: onSelectionChange,
              groupValue: selectedOption,
            ),
            const Text("No", style: _labelStyle),
          ],
        ),
      ],
    );
  }
}
