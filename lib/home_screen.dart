import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_system/about_us_screen.dart';
import 'package:hotel_management_system/login_screen.dart';
import 'package:hotel_management_system/menu_screen.dart';
import 'package:hotel_management_system/order_screen.dart';
import 'package:hotel_management_system/staff_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  void onPageChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Are you sure you want to Logout?',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(color: Colors.green),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Confirm',
                    style: GoogleFonts.poppins(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          width: double.infinity,
          child: Row(
            children: [
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          currentIndex == 0 ? Colors.white : Colors.black,
                      backgroundColor:
                          currentIndex == 0 ? Colors.black : Colors.white,
                    ),
                    onPressed: () {
                      pageController.jumpToPage(0);
                    },
                    child: Text(
                      "Home",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          currentIndex == 1 ? Colors.white : Colors.black,
                      backgroundColor:
                          currentIndex == 1 ? Colors.black : Colors.white,
                    ),
                    onPressed: () {
                      pageController.jumpToPage(1);
                    },
                    child: Text(
                      "Menu",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          currentIndex == 2 ? Colors.white : Colors.black,
                      backgroundColor:
                          currentIndex == 2 ? Colors.black : Colors.white,
                    ),
                    onPressed: () {
                      pageController.jumpToPage(2);
                    },
                    child: Text(
                      "About-Us",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 150),
              Text(
                'Hotel Order Management System',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextButton(
              child: Text(
                "Logout",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                showLogoutDialog(context);
              },
            ),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          OrderScreen(),
          MenuScreen(),
          AboutUsScreen(),
          LoginScreen(),
        ],
        onPageChanged: onPageChange,
      ),
    );
  }
}
