import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Notifications',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Restaurant Name',
                            style: TextStyle(
                              fontFamily: 'segoeUI',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5e5e5e),
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Time',
                            style: TextStyle(
                              fontFamily: 'segoeUI',
                              fontSize: 13,
                              color: Color(0xff5e5e5e),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        bottom: 20,
                      ),
                      child: Text(
                        'content',
                        style: TextStyle(
                          fontFamily: 'segoeUI',
                          fontSize: 13,
                          color: Color(0xff5e5e5e),
                        ),
                      ),
                    ),
                    if (index != 3)
                      Divider(indent: 15, endIndent: 15, color: Colors.black),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
