// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_management_system/menu_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<MenuItem> _menuItems = [
    MenuItem(name: 'Burger', price: 9.99, quantity: 1),
    MenuItem(name: 'Pizza', price: 12.99, quantity: 2),
    MenuItem(name: 'Salad', price: 7.99, quantity: 3),
    MenuItem(name: 'Pasta', price: 10.99, quantity: 4),
  ];

  List<MenuItem> _filteredItems = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _filteredItems = _menuItems;
    _filteredItems = List<MenuItem>.from(_menuItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMenuItems(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredItems = _menuItems
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _filteredItems = _menuItems;
      });
    }
  }

  void _changeName(int index, String newName) {
    setState(() {
      _filteredItems[index].name = newName;
    });
  }

  void _changePrice(int index, double newPrice) {
    setState(() {
      _filteredItems[index].price = newPrice;
    });
  }

  void _changeQuantity(index, newQuantity) {
    setState(() {
      _filteredItems[index].quantity = newQuantity;
    });
  }

  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _filteredItems.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}?$'),
                  ),
                ],
                controller: priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}?$'),
                  ),
                ],
                controller: quantityController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Quantity',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String itemName = nameController.text;
                double itemPrice = double.tryParse(priceController.text) ?? 0.0;
                double itemQuantity =
                    double.tryParse(quantityController.text) ?? 1;
                if (itemName.isNotEmpty && itemPrice > 0 && itemQuantity > 0) {
                  MenuItem newItem = MenuItem(
                      name: itemName, price: itemPrice, quantity: itemQuantity);
                  setState(() {
                    _menuItems.insert(0, newItem);
                    _filteredItems.insert(0, newItem);
                  });
                  Navigator.pop(context);
                } else {
                  // Display an error message or handle invalid input
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.all(16.0),
          //   color: Colors.white,
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       hintText: 'Search menu items',
          //       prefixIcon: Icon(Icons.search),
          //       filled: true,
          //       fillColor: Colors.grey[200],
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //         borderSide: BorderSide.none,
          //       ),
          //     ),
          //     onChanged: _filterMenuItems,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search menu items',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: _filterMenuItems,
                  ),
                ),
                SizedBox(width: 8.0),
                TextButton(
                  onPressed: () {
                    _showAddItemDialog();
                  },
                  child: Text('Add Item', style: GoogleFonts.poppins()),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                TextEditingController nameController =
                    TextEditingController(text: _filteredItems[index].name);
                TextEditingController priceController = TextEditingController(
                    text: '${_filteredItems[index].price.toString()} ₹');
                TextEditingController quantityController =
                    TextEditingController(
                        text: '${_filteredItems[index].quantity}');
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Card(
                    color: Colors.white,
                    // margin:
                    //     EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      title: TextField(
                        readOnly: true,
                        controller: nameController,
                        style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          _changeName(index, value);
                        },
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.poppins(
                                  fontSize: 14.0, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                labelText: 'Price',
                                labelStyle:
                                    GoogleFonts.poppins(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _changePrice(
                                    index, double.tryParse(value) ?? 0.0);
                              },
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: quantityController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.poppins(
                                  fontSize: 14.0, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                labelText: 'Quantity',
                                labelStyle:
                                    GoogleFonts.poppins(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _changeQuantity(
                                    index, double.tryParse(value) ?? 1);
                              },
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: Text(
                              "Change Name",
                              style: GoogleFonts.poppins(color: Colors.green),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => _buildChangeNameDialog(
                                    index, nameController.text),
                              );
                            },
                          ),
                          TextButton(
                            child: Text(
                              "Change Price",
                              style: GoogleFonts.poppins(
                                  color: Colors.deepPurpleAccent),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => _buildChangePriceDialog(
                                    index, priceController.text),
                              );
                            },
                          ),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      _buildChangeQuantityDialog(index,
                                          _filteredItems[index].quantity),
                                );
                              },
                              child: Text(
                                "Change Quantity",
                                style: GoogleFonts.poppins(),
                              )),
                          TextButton(
                            onPressed: () {
                              _deleteItem(index);
                            },
                            child: Text(
                              'Delete Item',
                              style: GoogleFonts.poppins(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeNameDialog(int index, String currentName) {
    TextEditingController newNameController =
        TextEditingController(text: currentName);

    return AlertDialog(
      title: Text('Change Name'),
      content: TextField(
        controller: newNameController,
        decoration: InputDecoration(
          labelText: 'New Name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _changeName(index, newNameController.text);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  Widget _buildChangeQuantityDialog(int index, double currentQuantity) {
    TextEditingController newQuantityController =
        TextEditingController(text: currentQuantity.toString());

    return AlertDialog(
      title: Text('Change Quantity'),
      content: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,2}?$'),
          ),
        ],
        controller: newQuantityController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: 'New Quantity',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _changeQuantity(
                index, int.tryParse(newQuantityController.text) ?? 0);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  Widget _buildChangePriceDialog(int index, String currentPrice) {
    TextEditingController newPriceController =
        TextEditingController(text: currentPrice);

    return AlertDialog(
      title: Text('Change Price'),
      content: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,2}?$'),
          ),
        ],
        controller: newPriceController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: 'New Price',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _changePrice(
                index, double.tryParse(newPriceController.text) ?? 0.0);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
