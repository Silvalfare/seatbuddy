import 'package:flutter/material.dart';
import 'package:seatbuddy/screen/edit_profile.dart';
import 'package:seatbuddy/screen/landing.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String id = "/profile";
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            // Spacer(),
            // IconButton(
            //   onPressed: () {
            //     Navigator.pushReplacementNamed(context, HomeScreen.id);
            //   },
            //   icon: Icon(Icons.exit_to_app),
            // ),
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
          Center(child: CircleAvatar(radius: 50, backgroundColor: Colors.grey)),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, EditProfileScreen.id);
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
            'Bob Smith',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: 'segoeUI',
            ),
          ),
          SizedBox(height: 10),
          Text(
            'bob@gmail.com',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          // Divider(indent: 15, endIndent: 15, color: Colors.black),
          // Text('Your Savings'),
          // Divider(indent: 15, endIndent: 15, color: Colors.black),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 25),
            child: CustomElevatedButton(
              text: 'Logout',
              onPressed: () {
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
