import 'package:flutter/material.dart';
import 'package:seatbuddy/api/user_api.dart';
import 'package:seatbuddy/screen/profile/edit_profile.dart';
import 'package:seatbuddy/screen/auth/landing.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String id = "/profile";
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService userService = UserService();
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    final userData = await userService.getUser();
    setState(() {
      name = userData['data']['name'];
      email = userData['data']['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          TextButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    initialName: name,
                    // initialEmail: email
                  ),
                ),
              );
              if (result == true) {
                getProfile();
              }
            },
            child: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 11,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Text(
            "${name ?? '-'}",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: 'segoeUI',
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${email ?? '-'}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 25),
            child: CustomElevatedButton(
              text: 'Logout',
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('auth_token');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LandingScreen.id,
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
