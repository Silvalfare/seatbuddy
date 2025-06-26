import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
              'History',
              style: TextStyle(
                fontFamily: 'segoeUI',
                fontSize: 16,
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
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 22,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              fontFamily: 'segoeUI',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5e5e5e),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Data',
                            style: TextStyle(
                              fontFamily: 'segoeUI',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Cancel Booking',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xffED4C5C),
                                fontFamily: 'segoeUI',
                                fontSize: 13,
                                color: Color(0xffED4C5C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 15),
                          Text(
                            'data',
                            style: TextStyle(
                              fontFamily: 'segoeUI',
                              color: Color(0xff5E5E5E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Edit Booking',
                              style: TextStyle(
                                color: Color(0xff00A144),
                                fontSize: 11,
                                fontFamily: 'segoeUI',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 30,
                        right: 30,
                        bottom: 20,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.people),
                          SizedBox(width: 15),
                          Text(
                            'data',
                            style: TextStyle(
                              fontFamily: 'segoeUI',
                              color: Color(0xff5E5E5E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.table_bar),
                          SizedBox(width: 15),
                          Text(
                            'Indoor',
                            style: TextStyle(
                              fontFamily: 'segoeUI',
                              color: Color(0xff5E5E5E),
                            ),
                          ),
                        ],
                      ),
                    ),
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
