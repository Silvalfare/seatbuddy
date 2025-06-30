import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:seatbuddy/screen/detail_menu.dart';
import 'package:seatbuddy/screen/profile/edit_profile.dart';
import 'package:seatbuddy/screen/home.dart';
import 'package:seatbuddy/screen/auth/landing.dart';
import 'package:seatbuddy/screen/auth/login.dart';
import 'package:seatbuddy/screen/profile/profile.dart';
import 'package:seatbuddy/screen/auth/register.dart';
import 'package:seatbuddy/screen/reserve.dart';
import 'package:seatbuddy/screen/auth/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        LandingScreen.id: (context) => LandingScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
        ReserveScreen.id: (context) => ReserveScreen(),
        DetailMenuScreen.id: (context) => DetailMenuScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      // home: const EditProfileScreen(),
    );
  }
}
