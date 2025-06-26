import 'package:flutter/material.dart';
import 'package:seatbuddy/screen/profile.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';
import 'package:seatbuddy/utils/custom_form_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const String id = "/edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text(
                'Your Profile',
                style: TextStyle(
                  fontFamily: 'segoeUI',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, ProfileScreen.id);
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(indent: 15, endIndent: 15, color: Colors.black),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(radius: 50, backgroundColor: Colors.grey),
            ),
            CustomFormTextField(
              controller: fullNameController,
              title: 'Full Name',
              hintText: 'Bob Smith',
            ),
            SizedBox(height: 20),
            CustomFormTextField(
              controller: emailController,
              title: 'Email',
              hintText: 'bob@gmail.com',
            ),
            SizedBox(height: 30),
            CustomElevatedButton(
              text: 'Confirm',
              onPressed: () {
                Navigator.pushReplacementNamed(context, ProfileScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
