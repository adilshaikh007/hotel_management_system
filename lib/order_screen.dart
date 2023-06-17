// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_system/order_model.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'print_pdf.dart';
import 'package:http/http.dart' as http;

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Color _dbuttonColor = Colors.pinkAccent;
  String _dbuttonText = 'Accept';
  bool _isDelivered = true;
  String _cbuttonText = 'Cancel';

  List<Order> _orders = [
    Order(
        ordernumber: 1,
        tableNumber: 1,
        itemName: 'Pizza',
        price: 120,
        quantity: 2,
        orderTime: DateTime(2023, 5, 29, 17, 30)),
    Order(
        ordernumber: 2,
        tableNumber: 2,
        itemName: 'Burger',
        price: 60,
        quantity: 1,
        orderTime: DateTime(2023, 5, 29, 18, 30)),
    Order(
        ordernumber: 3,
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

  Future<Uint8List> _createPdf(PdfPageFormat format) async {
    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
    );
    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: format,
    //     build: (context) {
    //       return pw.Container(
    //         width: double.infinity,
    //         child: pw.Column(
    //           mainAxisAlignment: pw.MainAxisAlignment.start,
    //           children: [
    //             pw.Text(
    //               'Follow',
    //               style: pw.TextStyle(
    //                 fontSize: 10,
    //                 fontWeight: pw.FontWeight.bold,
    //               ),
    //             ),
    //             pw.Container(
    //               width: 250,
    //               height: 1.5,
    //               margin: pw.EdgeInsets.symmetric(vertical: 5),
    //               color: PdfColors.black,
    //             ),
    //             pw.Container(
    //               width: 300,
    //               child: pw.Text(
    //                 '#30FlutterTips',
    //                 style: pw.TextStyle(
    //                   fontSize: 10,
    //                   fontWeight: pw.FontWeight.bold,
    //                 ),
    //                 textAlign: pw.TextAlign.center,
    //                 maxLines: 5,
    //               ),
    //             ),
    //             pw.Container(
    //               width: 250,
    //               height: 1.5,
    //               margin: pw.EdgeInsets.symmetric(vertical: 10),
    //               color: PdfColors.black,
    //             ),
    //             pw.Text(
    //               'Lakshydeep Vikram',
    //               style: pw.TextStyle(
    //                 fontSize: 5,
    //                 fontWeight: pw.FontWeight.bold,
    //               ),
    //             ),
    //             pw.Text(
    //               'Follow on Medium, LinkedIn, GitHub',
    //               style: pw.TextStyle(
    //                 fontSize: 5,
    //                 fontWeight: pw.FontWeight.bold,
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
    final gstRate = 18; // GST rate in percentage

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(
                  'Sheikh\'s Hotel',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              _buildBillInfoSection(),
              pw.Divider(),
              _buildItemsSection(),
              pw.Divider(),
              _buildTotalSection(gstRate),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  _buildBillInfoSection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Bill Number: 123456',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          'Date: June 5, 2023',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          'Customer Name: Adil Shaikh',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _buildItemsSection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Items:',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Bullet(
          text: 'Pizza - 200 Rs',
          style: pw.TextStyle(
            fontSize: 10,
          ),
        ),
        pw.Bullet(
          text: 'Biryani - 400 Rs',
          style: pw.TextStyle(
            fontSize: 10,
          ),
        ),
        pw.Bullet(
          text: 'Dum Aloo - 600 Rs',
          style: pw.TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  _buildTotalSection(int gstRate) {
    final totalAmount = 1100;
    final gstAmount = (totalAmount * gstRate / 100).toStringAsFixed(2);
    final grandTotal =
        (totalAmount + double.parse(gstAmount)).toStringAsFixed(2);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Total Amount: ${totalAmount.toStringAsFixed(2)} Rs',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          'GST (${gstRate.toString()}%): ${gstAmount} Rs',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Divider(),
        pw.Text(
          'Grand Total: ${grandTotal}Rs',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showPdfPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // Adjust the width as needed
            height: MediaQuery.of(context).size.height *
                0.8, // Adjust the height as needed
            child: FutureBuilder<Uint8List>(
              future: _createPdf(PdfPageFormat.legal),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PdfPreview(
                    initialPageFormat: PdfPageFormat.legal,
                    canDebug: false,
                    allowSharing: true,
                    canChangeOrientation: false,
                    onPrinted: (context) {
                      setState(() {
                        for (var order in _orders) {
                          order.billprinted = true;
                          //   order.kotbuttonText = 'KOT Printed';
                        }
                      });
                    },
                    onShared: (context) {
                      setState(() {
                        for (var order in _orders) {
                          order.billprinted = true;
                          //  order.kotbuttonText = 'Print KOT';
                        }
                      });
                    },
                    canChangePageFormat: false,
                    build: (format) => snapshot.data!,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                // Display a loading indicator while waiting for the PDF to be generated
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      },
    );
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
      for (var order in _orders) {
        if (order.cancelled == true && order.decreasepricetoggle == false) {
          _subTotalPrice = _subTotalPrice;
        }
        if (order.acceptbuttonpressed == true &&
            order.cancelled == true &&
            order.decreasepricetoggle == true) {
          _subTotalPrice -= price;
          _subtotalDecreased = true;
          order.decreasepricetoggle = false;
          break;
        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                          'Order Number: ',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        Text(
                          '${_orders[index].ordernumber} ',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(
                          width: 15,
                        ),
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
                            _orders[index].orderAccepted = true;
                            _orders[index].acceptbuttonpressed = true;
                            _addSubTotalPrice();
                            _addItemQuantity();
                          },
                          child: Text(
                            _orders[index].dbuttonText,
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(70, 70),
                              backgroundColor: _orders[index].kotprinted
                                  ? (_orders[index].billprinted
                                      ? Colors.green
                                      : Colors.black)
                                  : Colors.black),
                          onPressed: _orders[index].orderAccepted == false ||
                                  _orders[index].cancelled == true
                              ? null
                              : () {
                                  setState(() {
                                    _orders[index].kotprinted = true;
                                    // _orders[index].kotbuttonText =
                                    //     'KOT printed';
                                    _showPdfPreview(context);
                                  });
                                },
                          child: Text(
                            //  _orders[index].kotbuttonText,
                            _orders[index].kotprinted
                                ? (_orders[index].billprinted
                                    ? 'KOT Printed'
                                    : 'Print KOT')
                                : 'Print KOT',
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
                                                      _orders[index]
                                                              .decreasepricetoggle =
                                                          true;
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
}
