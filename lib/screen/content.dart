import 'package:flutter/material.dart';
import 'package:seatbuddy/api/menu_api.dart';
import 'package:seatbuddy/model/menu/menu_model.dart';
import 'package:seatbuddy/screen/detail_menu.dart';
import 'package:seatbuddy/screen/reserve.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late Future<List<MenuModel>> _menus;

  @override
  void initState() {
    super.initState();
    _menus = MenuApi.fetchMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Sign up for an account to receive 2% off your bill on every reservation!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 16),
                child: Row(
                  children: [
                    Text(
                      'Welcome to SeatBuddy',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'segoeUI',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 132),
                    Image.asset('assets/images/divider.png'),
                    SizedBox(width: 11),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 16,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 35, bottom: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Our ',
                        style: TextStyle(
                          color: Color(0xff5E5E5E),
                          fontSize: 19,
                          fontFamily: 'segoeUI',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Menu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontFamily: 'segoeUI',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(indent: 20, endIndent: 20, color: Colors.black),
              FutureBuilder<List<MenuModel>>(
                future: _menus,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Gagal memuat menu'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Menu kosong'));
                  }

                  final menus = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: 70),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menus.length,
                    itemBuilder: (context, index) {
                      final menu = menus[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, DetailMenuScreen.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Container(
                            width: 350,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      menu.imageUrl,
                                      width: 80,
                                      height: 65,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(menu.name),
                                    // Text(
                                    //   menu.description,

                                    //   overflow: TextOverflow.ellipsis,
                                    // ),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text('Rp ${menu.price}'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 200,
        height: 50,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.black,

          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, ReserveScreen.id);
          },
          child: Text(
            'Reserve Here',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'segoeUI',
            ),
          ),
        ),
      ),
    );
  }
}
