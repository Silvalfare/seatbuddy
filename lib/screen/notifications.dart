import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seatbuddy/api/reservation_api.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<dynamic> _reservations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    final response = await ReservationApi().getReservations();
    setState(() {
      _reservations = (response['data'] as List<dynamic>? ?? []);
      _isLoading = false;
    });
  }

  String formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat('d MMMM yyyy | HH:mm WIB', 'id_ID').format(dateTime);
  }

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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _reservations.isEmpty
          ? Center(child: Text('Belum ada reservasi'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _reservations.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = _reservations[index];
                      final status = "Booked";
                      final waktuBuat = formatDate(item['created_at']);
                      final detail =
                          "Reservasi untuk ${item['guest_count']} orang pada ${formatDate(item['reserved_at'])}\n${item['notes'] == null || item['notes'].toString().isEmpty ? "Tidak ada catatan" : "Catatan: ${item['notes']}"}";
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
                                  status,
                                  style: TextStyle(
                                    fontFamily: 'segoeUI',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff5e5e5e),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  waktuBuat,
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
                              detail,
                              style: TextStyle(
                                fontFamily: 'segoeUI',
                                fontSize: 13,
                                color: Color(0xff5e5e5e),
                              ),
                            ),
                          ),
                          if (index != 3)
                            Divider(
                              indent: 15,
                              endIndent: 15,
                              color: Colors.black,
                            ),
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
