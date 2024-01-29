import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.validator,
    this.onChanged,
  });
  final String label;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
            label: Text(
              label,
              style: GoogleFonts.roboto(),
            ),
            border: const OutlineInputBorder()),
      ),
    );
  }
}
