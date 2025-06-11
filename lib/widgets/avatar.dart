import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.text = ''});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[400],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
