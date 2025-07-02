import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String title;

  const CustomFormTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'segoeUI',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 40,
          width: 311,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            style: TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            cursorHeight: 20,
            cursorWidth: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              labelStyle: TextStyle(color: Colors.black),
              hintText: hintText,
              hintStyle: TextStyle(color: Color(0xffCECECE)),
              filled: true,

              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
