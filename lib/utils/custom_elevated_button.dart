import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.foregroundColor = Colors.white,
  });
  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 2),
      child: SizedBox(
        width: 311,
        height: 40,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            disabledBackgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
            ),
            elevation: 0,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'SegoeUI',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
