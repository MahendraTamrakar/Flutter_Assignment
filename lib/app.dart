import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment/widgets/bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
      statusBarColor: Colors.white, // matches AppBar background
      statusBarIconBrightness: Brightness.dark, // makes icons dark
      systemNavigationBarColor: Colors.white,
    
      ),
    );

    return MaterialApp(
      title: "MyApp",
      debugShowCheckedModeBanner: false,
     theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        textTheme: GoogleFonts.workSansTextTheme(),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
      ),
          backgroundColor: Colors.white,
          titleTextStyle: GoogleFonts.workSans(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      home: const BottomNavLayout(),
    );
  }
}