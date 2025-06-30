import 'package:flutter/material.dart';
import 'package:seatbuddy/api/reservation_api.dart';
import 'package:seatbuddy/api/user_api.dart';
import 'package:seatbuddy/utils/custom_elevated_button.dart';
import 'package:seatbuddy/utils/custom_form_text_field.dart';

class ReserveScreen extends StatefulWidget {
  const ReserveScreen({super.key});
  static const String id = 'reserve_screen';

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  final TextEditingController _notesController = TextEditingController();
  final PageController _controller = PageController();
  final List<String> imgList = [
    'assets/images/interior.png',
    'assets/images/interior2.png',
    'assets/images/interior3.png',
  ];
  int _currentPage = 0;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _selectedPeople = 2;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime(2101),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      final minTime = TimeOfDay(hour: 10, minute: 30);
      final maxTime = TimeOfDay(hour: 23, minute: 00);

      bool isAfterMin =
          picked.hour > minTime.hour ||
          (picked.hour == minTime.hour && picked.minute >= minTime.minute);
      bool isBeforeMax =
          picked.hour < maxTime.hour ||
          (picked.hour == maxTime.hour && picked.minute <= maxTime.minute);

      if (isAfterMin && isBeforeMax) {
        setState(() => _selectedTime = picked);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Please select a time between 10:30 and 23:00'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Restoran Nusantara Rasa',
          style: TextStyle(fontFamily: 'segoeUI', fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(indent: 15, endIndent: 15, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _controller,
                      itemCount: imgList.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imgList[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      },
                    ),
                    // Left arrow
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(Icons.chevron_left, color: Colors.black),
                        onPressed: () {
                          if (_currentPage > 0) {
                            _controller.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                    // Right arrow
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(Icons.chevron_right, color: Colors.black),
                        onPressed: () {
                          if (_currentPage < imgList.length - 1) {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                    //dots indicator
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(imgList.length, (index) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 15),
                      SizedBox(width: 5),
                      Text('Jl. Serdang Baru 1 No.47'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('Kemayoran, Jakarta Pusat 10650'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Row(
                children: [
                  Icon(Icons.timer_rounded, size: 15),
                  SizedBox(width: 5),
                  Text('10:30 AM - 11:00 PM'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Description',
                style: TextStyle(
                  fontFamily: 'segoeUI',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Text(
                'Restoran Nusantara Rasa menghadirkan beragam hidangan khas Indonesia dari berbagai daerah, '
                'mulai dari rendang Padang, gudeg Jogja, ayam betutu Bali, hingga pempek Palembang. '
                'Dengan suasana nyaman dan pelayanan ramah, kami siap memanjakan lidah Anda dengan kekayaan cita rasa Nusantara yang otentik.',
                style: TextStyle(fontSize: 13),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _pickDate(context),
                    child: Container(
                      height: 36,
                      width: 110,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Icon(Icons.calendar_today),
                          SizedBox(width: 5),
                          SizedBox(
                            child: Text(
                              _selectedDate == null
                                  ? 'Date'
                                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    child: GestureDetector(
                      onTap: () => _pickTime(context),
                      child: Container(
                        height: 36,
                        width: 110,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Icon(Icons.access_time),
                            SizedBox(width: 5),
                            SizedBox(
                              child: Text(
                                _selectedTime == null
                                    ? 'Time'
                                    : _selectedTime!.format(context),
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    child: Container(
                      height: 36,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _selectedPeople,
                          icon: Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          items: List.generate(6, (index) => index + 1)
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 8),
                                      Icon(Icons.people),
                                      SizedBox(width: 8),
                                      Text(
                                        '$e People',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedPeople = val!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomFormTextField(
                controller: _notesController,
                title: 'Notes (Optional)',
                hintText: 'Contoh: Meja dekat pintu',
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomElevatedButton(
                text: 'Reserve',
                onPressed: () async {
                  if (_selectedDate == null || _selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select date and time')),
                    );
                    return;
                  }

                  // Gabungkan tanggal dan waktu jadi satu DateTime
                  final DateTime reservedAt = DateTime(
                    _selectedDate!.year,
                    _selectedDate!.month,
                    _selectedDate!.day,
                    _selectedTime!.hour,
                    _selectedTime!.minute,
                  );

                  final success = await ReservationApi().createReservation(
                    reservedAt: reservedAt,
                    guestCount: _selectedPeople,
                    notes: _notesController.text
                        .trim(), // Optional, bisa dinamis
                  );

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Reservasi berhasil dilakukan')),
                    );
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal melakukan reservasi')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
