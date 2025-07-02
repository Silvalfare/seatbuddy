import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seatbuddy/api/reservation_api.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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

  Future<void> cancelBooking(int id) async {
    final success = await ReservationApi().cancelReservation(id);
    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Reservasi dibatalkan')));
      fetchReservations(); // Refresh data
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal membatalkan reservasi')));
    }
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _reservations.isEmpty
          ? Center(child: Text('Belum ada reservasi'))
          : SingleChildScrollView(
              child: Column(
                children: List.generate(_reservations.length, (index) {
                  final item = _reservations[index];
                  final waktuReservasi = formatDate(item['reserved_at']);
                  final guestCount = item['guest_count'] ?? '0';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 30,
                          right: 30,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Reserved',
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
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Batalkan Reservasi'),
                                    content: Text(
                                      'Apakah Anda yakin ingin membatalkan reservasi ini?',
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'Tidak',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Ya',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          cancelBooking(item['id']);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
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
                              waktuReservasi,
                              style: TextStyle(
                                fontFamily: 'segoeUI',
                                color: Color(0xff5E5E5E),
                                fontWeight: FontWeight.bold,
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
                              '$guestCount guest',
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
                              'Indoor', // placeholder
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
                }),
              ),
            ),
    );
  }
}
