import 'package:eye_glass/models/prescription.dart';
import 'package:eye_glass/providers/prescription_provider.dart';
import 'package:flutter/material.dart';

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({super.key, required this.provider});

  final PrescriptionProvider provider;
  @override
  Widget build(BuildContext context) {
    LensOption? selected = provider.selectedCategory;
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select Category', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: LensOption.values.map((category) {
                  final isSelected = selected == category;
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => selected = category);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      provider.filterByCategory(null);
                      Navigator.pop(context);
                    },
                    child: const Text('Clear Filter'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provider.filterByCategory(selected);
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
