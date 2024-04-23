import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {

  const ColoredButton({
    super.key, 
    required this.color, 
    required this.text, 
    required this.onTap,
    });

    final Color color;
    final String text;
    final void Function() onTap;

  @override
  Widget build(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(180, 180),
        backgroundColor: color,
      ),
      onPressed: onTap,
      child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 30)),
    );
  }
}