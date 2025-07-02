import 'package:flutter/material.dart';
import 'package:seatbuddy/api/user_api.dart';
import 'package:seatbuddy/screen/auth/login.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';
import 'package:seatbuddy/utils/custom_form_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String id = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserService userService = UserService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = false;
  final _formkey = GlobalKey<FormState>();

  void register() async {
    final res = await userService.registerUser(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    if (res["data"] != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Pendaftaran Berhasil'),
        ),
      );
      Navigator.pushNamed(context, LoginScreen.id);
    } else if (res["errors"] != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Maaf, ${res["message"]}'),
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
            child: Column(
              children: [
                SizedBox(height: 48),
                Text(
                  "Let's get you started",
                  style: TextStyle(
                    fontFamily: 'segoeUI',
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                CustomFormTextField(
                  controller: nameController,
                  title: 'Full Name',
                  hintText: 'Bob Smith',
                ),
                SizedBox(height: 20),
                CustomFormTextField(
                  controller: emailController,
                  title: 'Email Address',
                  hintText: 'bob@gmail.com',
                ),
                SizedBox(height: 20),
                CustomFormTextField(
                  controller: passwordController,
                  title: 'Password',
                  hintText: '********',
                  obscureText: !isVisible,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                CustomElevatedButton(
                  text: 'Register',
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      register();
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a user?',
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
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'Sign in',
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
                // SizedBox(height: 150),
                Spacer(),
                Image.asset('assets/images/Frame.png'),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
