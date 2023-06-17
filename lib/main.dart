// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_system/about_us_screen.dart';
import 'package:hotel_management_system/print_pdf.dart';
import 'package:hotel_management_system/home_screen.dart';
import 'package:hotel_management_system/login_screen.dart';
import 'package:hotel_management_system/order_model.dart';
import 'package:hotel_management_system/order_screen.dart';
import 'package:hotel_management_system/staff_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/order': (context) => OrderScreen(),
        '/staff_info': (context) => StaffDetailsScreen(),
        '/about_us': (context) => AboutUsScreen(),
        '/login': (context) => LoginScreen(),
        //    "/printpreview": (context) => PrintPdf(),
        '/home': (context) => HomeScreen(),
      },
      home: LoginScreen(),
    );
  }
}


















// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     PageController pageController = PageController();
//     int selectedPage = 0;

//     onPageChange(int index) {
//       setState(() {
//         selectedPage = index;
//       });
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         // centerTitle: true,
//         elevation: 0,
//         // leading: TextButton(
//         //     style: TextButton.styleFrom(foregroundColor: Colors.black),
//         //     onPressed: () {
//         //       Navigator.of(context).pushNamed("/staff_info");
//         //     },
//         //     child: Text("Staff Info")),

//         title: Container(
//           width: double.infinity,
//           child: Row(
//             children: [
//               Row(
//                 children: [
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.black),
//                       onPressed: () {
//                         Navigator.of(context).pushReplacementNamed("/home");
//                       },
//                       child: Text(
//                         "Home",
//                         style: GoogleFonts.poppins(),
//                       )),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   // TextButton(
//                   //     style:
//                   //         TextButton.styleFrom(foregroundColor: Colors.black),
//                   //     onPressed: () {
//                   //       Navigator.of(context).pushNamed("/staff_info");
//                   //     },
//                   //     child: Text("Revenue")),
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.black),
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pushReplacementNamed("/staff_info");
//                       },
//                       child:
//                           Text("Staff Details", style: GoogleFonts.poppins())),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.black),
//                       onPressed: () {
//                         Navigator.of(context).pushReplacementNamed("/about_us");
//                       },
//                       child: Text("About-Us", style: GoogleFonts.poppins())),
//                 ],
//               ),
//               SizedBox(
//                 width: 150,
//               ),
//               Text(
//                 'Hotel Order Management System',
//                 style: Theme.of(context).textTheme.headline1,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextButton(
//                 child: Text(
//                   "Logout",
//                   style: GoogleFonts.poppins(),
//                 ),
//                 style: TextButton.styleFrom(
//                     foregroundColor: Colors.white, backgroundColor: Colors.red),
//                 onPressed: () {
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           backgroundColor: Colors.black,
//                           title: Text(
//                             'Are you sure you want to Logout?',
//                             style: GoogleFonts.poppins(color: Colors.white),
//                           ),
//                           actions: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: <Widget>[
//                                 TextButton(
//                                   child: Text(
//                                     'Cancel',
//                                     style: GoogleFonts.poppins(
//                                         color: Colors.green),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                                 TextButton(
//                                   child: Text(
//                                     'Confirm',
//                                     style:
//                                         GoogleFonts.poppins(color: Colors.red),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pushReplacementNamed("/login");
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       });
//                 }),
//           )
//         ],
//       ),
//       body: PageView(
//         controller: pageController,
//         children: const [
//           HomeScreen(),
//           StaffDetailsScreen(),
//           AboutUsScreen(),
//           LoginScreen(),
//         ],
//         onPageChanged: (index) {
//           onPageChange(index);
//         },
//       ),
//     );
//   }
// }
