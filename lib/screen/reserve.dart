import 'package:flutter/material.dart';

class ReserveScreen extends StatefulWidget {
  const ReserveScreen({super.key});
  static const String id = 'reserve_screen';

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  final PageController _controller = PageController();
  final List<String> imgList = [
    'assets/images/logo.png',
    'assets/images/splash.png',
    'assets/images/Group.png',
  ];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Restaurant Name',
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
      body: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
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
                  left: 8,
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
                  right: 8,
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
              ],
            ),
          ),
          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imgList.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.black : Colors.grey,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
