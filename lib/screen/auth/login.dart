import 'package:flutter/material.dart';
import 'package:seatbuddy/api/user_api.dart';
import 'package:seatbuddy/screen/home.dart';
import 'package:seatbuddy/screen/auth/register.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';
import 'package:seatbuddy/utils/custom_form_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = "/login";

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final UserService userService = UserService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = false;
  final _formkey = GlobalKey<FormState>();

  void Login() async {
    final res = await userService.loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (res["data"] != null) {
      print('User: ${res['data']['user']}');
      print('Token: ${res['data']['token']}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', res['data']['token']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Login Berhasil'),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.id,
        (route) => false,
      );
    } else if (res["errors"] != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Maaf, ${res["message"]}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('${res["message"]}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
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
                    controller: passwordController,
                    title: 'Password',
                    obscureText: !isVisible,
                    hintText: '********',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(
                        isVisible ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomElevatedButton(
                    text: 'Login',
                    onPressed: () async {
                      Login();
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
      ),
    );
  }
}
