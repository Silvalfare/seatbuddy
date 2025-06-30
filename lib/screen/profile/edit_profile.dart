import 'package:flutter/material.dart';
import 'package:seatbuddy/api/user_api.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';
import 'package:seatbuddy/utils/custom_form_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  final String? initialName;
  // final String? initialEmail;
  const EditProfileScreen({
    super.key,
    this.initialName,
    // this.initialEmail
  });
  static const String id = "/edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserService userService = UserService();
  late TextEditingController fullNameController = TextEditingController();
  // late TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.initialName ?? '');
    // emailController = TextEditingController(text: widget.initialEmail ?? '');
  }

  Future<void> updateUser() async {
    try {
      await userService.updateUser(
        name: fullNameController.text,
        // email: emailController.text,
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Gagal update profile'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  Navigator.pop(context);
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
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 75),
              ),
            ),
            CustomFormTextField(
              controller: fullNameController,
              title: 'Full Name',
              hintText: 'Bob Smith',
            ),
            SizedBox(height: 20),
            // CustomFormTextField(
            //   controller: emailController,
            //   title: 'Email',
            //   hintText: 'bob@gmail.com',
            // ),
            SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Confirm',
              onPressed: () {
                updateUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
