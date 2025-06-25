import 'package:flutter/material.dart';
import 'package:seatbuddy/screen/login.dart';
import 'package:seatbuddy/screen/register.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  static const String id = "/landing";

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Text('data'),
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 86),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: CustomElevatedButton(
              text: 'Login',
              borderColor: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: CustomElevatedButton(
              text: 'Register',
              borderColor: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, RegisterScreen.id);
              },
            ),
          ),
          SizedBox(height: 36),
          Divider(indent: 32, endIndent: 32, color: Colors.white),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Sign up for an account to receive 2% off your bill on every reservation!',
              style: TextStyle(
                fontFamily: 'segoeUI',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 200),
          Image.asset('assets/images/Group.png'),
        ],
      ),
    );
  }
}
