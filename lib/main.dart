// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_system/login_screen.dart';
import 'package:hotel_management_system/order_list_screen.dart';
import 'package:hotel_management_system/staff_details_screen.dart';
import 'new_order_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
              fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyText1: GoogleFonts.poppins(fontSize: 16.0),
          bodyText2: GoogleFonts.poppins(fontSize: 14.0),
        ),
      ),
      home: NewOrderListScreen(),
      routes: {
        "/orderscreen": (context) => NewOrderListScreen(),
        "/staff_info": (context) => StaffDetailsScreen(),
        "/login_screen": (context) => LoginScreen(),
      },
    );
  }
}
