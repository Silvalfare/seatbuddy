import 'package:flutter/material.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';
import 'package:seatbuddy/utils/custom_form_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        body: SafeArea(
          child: Column(
            children: [
              CustomElevatedButton(text: 'Login'),
              CustomFormTextField(controller: emailController, title: 'Email'),
            ],
          ),
        ),
      ),
    );
  }
}
