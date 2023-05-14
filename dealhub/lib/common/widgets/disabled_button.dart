import 'package:flutter/material.dart';

class DisabledButton extends StatelessWidget {
  final String text;
  final Color? color;
  const DisabledButton({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? Colors.white : Colors.black,
        ),
      ),
      onPressed: null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
