// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_system/order_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _dbuttonColor = Colors.pinkAccent;
  String _dbuttonText = 'Accept';
  bool _isDelivered = true;
  String _cbuttonText = 'Cancel';
  List<Order> _orders = [
    Order(
        tableNumber: 1,
        itemName: 'Pizza',
        price: 120,
        quantity: 2,
        orderTime: DateTime(2023, 5, 29, 17, 30)),
    Order(
        tableNumber: 2,
        itemName: 'Burger',
        price: 60,
        quantity: 1,
        orderTime: DateTime(2023, 5, 29, 18, 30)),
    Order(
        tableNumber: 3,
        itemName: 'Sushi',
        price: 200,
        quantity: 3,
        orderTime: DateTime(2023, 5, 29, 19, 30)),
  ];
  int _subTotalQuantity = 0;
  double _subTotalPrice = 0;
  bool _subtotalUpdated = false;
  bool _subtotalDecreased = false;
  @override
  void initState() {
    super.initState();
    _addSubTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // centerTitle: true,
        elevation: 0,
        // leading: TextButton(
        //     style: TextButton.styleFrom(foregroundColor: Colors.black),
        //     onPressed: () {
        //       Navigator.of(context).pushNamed("/staff_info");
        //     },
        //     child: Text("Staff Info")),

        title: Container(
          width: double.infinity,
          child: Row(
            children: [
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/home");
                      },
                      child: Text(
                        "Home",
                        style: GoogleFonts.poppins(),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  // TextButton(
                  //     style:
                  //         TextButton.styleFrom(foregroundColor: Colors.black),
                  //     onPressed: () {
                  //       Navigator.of(context).pushNamed("/staff_info");
                  //     },
                  //     child: Text("Revenue")),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/staff_info");
                      },
                      child:
                          Text("Staff Details", style: GoogleFonts.poppins())),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/about_us");
                      },
                      child: Text("About-Us", style: GoogleFonts.poppins())),
                ],
              ),
              SizedBox(
                width: 150,
              ),
              Text(
                'Hotel Order Management System',
                style: Theme.of(context).textTheme.headline1,
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
                  style: GoogleFonts.poppins(),
                ),
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black),
                onPressed: () {
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
                                    style: GoogleFonts.poppins(
                                        color: Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Confirm',
                                    style:
                                        GoogleFonts.poppins(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed("/login");
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      });
                }),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    tileColor: Colors.cyan,
                    title: Row(
                      children: [
                        Text('${_orders[index].itemName}',
                            style: GoogleFonts.poppins(
                                color: Colors.orangeAccent,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    subtitle: Text(
                        'Ordered ${_getOrderTimeAgoString(_orders[index].orderTime)}',
                        style: GoogleFonts.poppins(color: Colors.white)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total Price: ',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        Text(
                          '${_orders[index].price * _orders[index].quantity} ₹',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Price: ',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        Text(
                          '${_orders[index].price} ₹',
                          style: GoogleFonts.poppins(
                              color: Colors.lightGreenAccent, fontSize: 18),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Table Number: ',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        Text(
                          '${_orders[index].tableNumber}',
                          style: GoogleFonts.poppins(
                              color: Colors.yellow, fontSize: 15),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Quantity: ',
                            style: GoogleFonts.poppins(color: Colors.white)),
                        Text('${_orders[index].quantity}',
                            style: GoogleFonts.poppins(
                                color: Colors.yellow, fontSize: 15)),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Order Time: ',
                            style: GoogleFonts.poppins(color: Colors.white)),
                        Text('${_getOrderTimeString(_orders[index].orderTime)}',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 15)),
                        SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(70, 70),
                              backgroundColor: _orders[index].delivered
                                  ? Colors.green
                                  : Colors.pinkAccent),
                          onPressed: () {
                            setState(() {
                              _orders[index].delivered = true;
                              if (_orders[index].delivered) {
                                _orders[index].cancelled = false;
                                _orders[index].cbuttonText = 'Cancel';
                                _orders[index].dbuttonText = 'Accepted';
                              } else {
                                _orders[index].dbuttonText = 'Accept';
                              }
                            });
                            _addSubTotalPrice();
                            _addItemQuantity();
                          },
                          child: Text(
                            _orders[index].dbuttonText,
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _orders[index].cancelled
                                  ? Colors.red
                                  : Colors.amber,
                              minimumSize: Size(70, 70)),
                          onPressed: _orders[index].cancelled
                              ? null
                              : () {
                                  setState(() {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.black,
                                            title: Text(
                                              'Are you sure you want to Cancel?',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  TextButton(
                                                    child: Text(
                                                      'Cancel',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text(
                                                      'Confirm',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.green),
                                                    ),
                                                    onPressed: () {
                                                      _orders[index].cancelled =
                                                          true;
                                                      if (_orders[index]
                                                          .cancelled) {
                                                        _orders[index]
                                                            .delivered = false;
                                                        _orders[index]
                                                                .dbuttonText =
                                                            'Accept';
                                                        _orders[index]
                                                                .cbuttonText =
                                                            'Cancelled';
                                                        var price =
                                                            _orders[index]
                                                                    .price *
                                                                _orders[index]
                                                                    .quantity;
                                                        _decreaseSubTotalPrice(
                                                            price);
                                                        var quantity =
                                                            _orders[index]
                                                                .quantity;
                                                        _decreaseItemQuantity(
                                                            quantity);
                                                      } else {
                                                        _orders[index]
                                                                .cbuttonText =
                                                            'Cancel';
                                                      }
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        });
                                  });
                                },
                          child: Text(_orders[index].cbuttonText,
                              style: GoogleFonts.poppins(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.lightGreenAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Net Revenue: ${_subTotalPrice} ₹',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Total Number of Orders delivered: ${_subTotalQuantity}",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getOrderTimeAgoString(DateTime orderTime) {
    final now = DateTime.now();
    final difference = now.difference(orderTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  _getOrderTimeString(DateTime orderTime) {
    final time = DateFormat('dd MMMM yyyy hh:mm a').format(orderTime);
    return time;
  }

  void _addSubTotalPrice() {
    _subTotalPrice = 0;
    for (var order in _orders) {
      if (order.delivered && !order.cancelled) {
        double totalItemPrice = order.price * order.quantity;
        _subTotalPrice = _subTotalPrice + totalItemPrice;
      }
    }
  }

  void _decreaseSubTotalPrice(double price) {
    setState(() {
      _subTotalPrice -= price;
      _subtotalDecreased = true;
      if (_subTotalPrice < 0) {
        _subTotalPrice = 0;
      }
    });
  }

  void _addItemQuantity() {
    _subTotalQuantity = 0;
    for (var order in _orders) {
      if (order.delivered && !order.cancelled) {
        int quan = order.quantity;
        _subTotalQuantity += quan;
      }
    }
  }

  void _decreaseItemQuantity(int quantity) {
    setState(() {
      _subTotalQuantity -= quantity;
      if (_subTotalQuantity < 0) {
        _subTotalQuantity = 0;
      }
    });
  }
}
