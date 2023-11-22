import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final void Function()? onTap;
  final double height;
  final double width;
  final Color? color;
  final Color? color2;
  final String text;
  const CustomBtn(
      {super.key,
      this.onTap,
      required this.height,
      required this.width,
      this.color2,
      this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
