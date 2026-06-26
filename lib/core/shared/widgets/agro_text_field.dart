import 'package:flutter/material.dart';

class AgroTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? icon;
  final TextInputType keyboardType;
  final String? suffixText;
  final String? prefixText;
  final bool isRequired;
  final bool isNumeric;
  final ValueChanged<String>? onChanged;
  final String? helperText;

  const AgroTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.suffixText,
    this.prefixText,
    this.isRequired = false,
    this.isNumeric = false,
    this.onChanged,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixText: suffixText,
        prefixText: prefixText,
        helperText: helperText,
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Este campo es obligatorio';
        }
        if (isNumeric && value != null && value.isNotEmpty) {
          if (double.tryParse(value) == null) {
            return 'Ingrese un valor numérico válido';
          }
        }
        return null;
      },
    );
  }
}
