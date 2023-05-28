class Order {
  int tableNumber;
  String itemName;
  double price;
  int quantity;
  DateTime orderTime;
  bool delivered;
  bool cancelled;
  String dbuttonText;
  String cbuttonText;
  bool subtotalUpdated;
  bool subtotalDecreased;
  Order({
    required this.tableNumber,
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.orderTime,
    this.delivered = false,
    this.cancelled = false,
    this.subtotalUpdated = false,
    this.subtotalDecreased = false,
  })  : dbuttonText = delivered ? 'Accepted' : 'Accept',
        cbuttonText = cancelled ? 'Cancelled' : 'Cancel';
}















// class Order {
//   int tableNumber;
//   String itemName;
//   double price;
//   int quantity;
//   DateTime orderTime;
//   bool delivered;
//   bool cancelled;
//   bool subtotalUpdated;
//   bool subtotalDecreased;

//   Order({
//     required this.tableNumber,
//     required this.itemName,
//     required this.price,
//     required this.quantity,
//     required this.orderTime,
//     this.delivered = false,
//     this.cancelled = false,
//     this.subtotalUpdated = false,
//     this.subtotalDecreased = false,
//   });
// }
