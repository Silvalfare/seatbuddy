import 'package:flutter/material.dart';
import 'package:seatbuddy/screen/home.dart';
import 'package:seatbuddy/screen/auth/register.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';
import 'package:seatbuddy/utils/custom_form_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = "/login";

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'SeatBuddy',
            style: TextStyle(
              fontSize: 33,
              fontFamily: 'segoeUI',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 48),
                Text(
                  "Let's get you back in",
                  style: TextStyle(
                    fontFamily: 'segoeUI',
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                CustomFormTextField(
                  controller: emailController,
                  title: 'Email Address',
                  hintText: 'bob@gmail.com',
                ),
                SizedBox(height: 20),
                CustomFormTextField(
                  controller: emailController,
                  title: 'Password',
                  hintText: '********',
                ),
                SizedBox(height: 30),
                CustomElevatedButton(
                  text: 'Login',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      HomeScreen.id,
                      (route) => false,
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Color(0xff5E5E5E),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'segoeUI',
                        fontSize: 17,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'segoeUI',
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 240),
                Image.asset('assets/images/Frame.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
