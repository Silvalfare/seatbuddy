import 'package:flutter/material.dart';
import 'package:seatbuddy/screen/auth/landing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changePage() {
    Future.delayed(Duration(seconds: 1), () async {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LandingScreen.id,
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    changePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(color: Colors.black, height: 65),
          Container(
            decoration: BoxDecoration(color: Color(0xff000000)),

            width: double.infinity,
            child: Image.asset(fit: BoxFit.cover, 'assets/images/splash.png'),
          ),
        ],
      ),
    );
  }
}
