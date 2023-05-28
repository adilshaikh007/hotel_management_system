// // ignore_for_file: prefer_final_fields, unused_field, library_private_types_in_public_api, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use, unnecessary_brace_in_string_interps
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hotel_management_system/order_model.dart';

// class OrderListScreen extends StatefulWidget {
//   @override
//   _OrderListScreenState createState() => _OrderListScreenState();
// }

// class _OrderListScreenState extends State<OrderListScreen> {
//   Color _dbuttonColor = Colors.pinkAccent;
//   String _dbuttonText = 'Accept';
//   bool _isDelivered = true;
//   String _cbuttonText = 'Cancel';
//   List<Order> _orders = [
//     Order(
//         tableNumber: 1,
//         itemName: 'Pizza',
//         price: 120,
//         quantity: 2,
//         orderTime: DateTime.now().subtract(Duration(minutes: 10))),
//     Order(
//         tableNumber: 2,
//         itemName: 'Burger',
//         price: 60,
//         quantity: 1,
//         orderTime: DateTime.now().subtract(Duration(hours: 1))),
//     Order(
//         tableNumber: 3,
//         itemName: 'Sushi',
//         price: 200,
//         quantity: 3,
//         orderTime: DateTime.now().subtract(Duration(minutes: 30))),
//   ];

//   double _subtotal = 0;

//   @override
//   void initState() {
//     super.initState();
//     _updateSubtotal();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         elevation: 0,
//         title: Text(
//           'Hotel Order Management System',
//           style: Theme.of(context).textTheme.headline1,
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _orders.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16.0),
//                   ),
//                   elevation: 4,
//                   child: ListTile(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16.0),
//                     ),
//                     tileColor: Colors.cyan,
//                     title: Row(
//                       children: [
//                         Text('${_orders[index].itemName}',
//                             style: GoogleFonts.poppins(
//                                 color: Colors.lightGreenAccent,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     subtitle: Text(
//                         'Ordered ${_getOrderTimeString(_orders[index].orderTime)}',
//                         style: GoogleFonts.poppins(color: Colors.white)),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Total Price: ',
//                           style: GoogleFonts.poppins(color: Colors.white),
//                         ),
//                         Text(
//                           '${_orders[index].price * _orders[index].quantity} ₹',
//                           style: GoogleFonts.poppins(
//                               color: Colors.black, fontSize: 18),
//                         ),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           'Price: ',
//                           style: GoogleFonts.poppins(color: Colors.white),
//                         ),
//                         Text(
//                           '${_orders[index].price} ₹',
//                           style: GoogleFonts.poppins(
//                               color: Colors.lightGreenAccent, fontSize: 18),
//                         ),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           'Table Number: ',
//                           style: GoogleFonts.poppins(color: Colors.white),
//                         ),
//                         Text(
//                           '${_orders[index].tableNumber}',
//                           style: GoogleFonts.poppins(
//                               color: Colors.yellow, fontSize: 15),
//                         ),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text('Quantity: ',
//                             style: GoogleFonts.poppins(color: Colors.white)),
//                         Text('${_orders[index].quantity}',
//                             style: GoogleFonts.poppins(
//                                 color: Colors.yellow, fontSize: 15)),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               minimumSize: Size(70, 70),
//                               backgroundColor: _orders[index].delivered
//                                   ? Colors.green
//                                   : Colors.pinkAccent),
//                           onPressed: _orders[index].cancelled
//                               ? null
//                               : () {
//                                   setState(() {
//                                     _orders[index].delivered = true;
//                                     _dbuttonColor = _orders[index].delivered
//                                         ? Colors.green
//                                         : Colors.pinkAccent;
//                                     _dbuttonText = _orders[index].delivered
//                                         ? 'Accepted'
//                                         : 'Accept';
//                                   });
//                                   _updateSubtotal();
//                                 },
//                           child: Text(
//                             _dbuttonText = _orders[index].delivered
//                                 ? 'Accepted'
//                                 : 'Accept',
//                             style: GoogleFonts.poppins(fontSize: 18),
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: _orders[index].cancelled
//                                   ? Colors.red
//                                   : Colors.amber,
//                               minimumSize: Size(70, 70)),
//                           onPressed: _orders[index].delivered
//                               ? null
//                               : () {
//                                   setState(() {
//                                     _orders[index].cancelled = true;
//                                     _cbuttonText = _orders[index].cancelled
//                                         ? 'Cancelled'
//                                         : 'Cancel';
//                                   });
//                                   _updateSubtotal();
//                                 },
//                           child: Text(
//                               _cbuttonText = _orders[index].cancelled
//                                   ? 'Cancelled'
//                                   : 'Cancel',
//                               style: GoogleFonts.poppins(fontSize: 18)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(16),
//             color: Colors.lightGreenAccent,
//             child: Center(
//               child: Text(
//                 'Net Revenue: ${_subtotal} ₹',
//                 style: GoogleFonts.poppins(
//                   color: Colors.black,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getOrderTimeString(DateTime orderTime) {
//     final now = DateTime.now();
//     final difference = now.difference(orderTime);
//     if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes}m ago';
//     } else {
//       return 'Just now';
//     }
//   }

//   void _updateSubtotal() {
//     _subtotal = 0;
//     for (var order in _orders) {
//       if (order.delivered) {
//         double totalItemPrice = order.price * order.quantity;
//         _subtotal += totalItemPrice;
//       }
//     }
//   }
// }
