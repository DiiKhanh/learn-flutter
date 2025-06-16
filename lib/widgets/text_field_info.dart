import 'package:flutter/material.dart';
import 'package:my_app/utils/validation.dart';

class TextFieldInfo extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enabled;

  const TextFieldInfo({
    super.key,
    required this.controller,
    required this.hintText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey[100],
        ),
        style: TextStyle(
          fontSize: 16,
          color: enabled ? Colors.black : Colors.grey[600],
        ),
        validator:
            enabled
                ? (value) {
                  if (ValidationUtils.isEmpty(value)) {
                    return 'This field is required';
                  }
                  return null;
                }
                : null,
      ),
    );
  }
}
