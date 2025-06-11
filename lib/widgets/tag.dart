import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({super.key, this.text = ""});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.teal[200]!),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.teal,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
