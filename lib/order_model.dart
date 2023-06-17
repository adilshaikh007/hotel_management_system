class Order {
  int tableNumber;
  String itemName;
  double price;
  int quantity;
  int ordernumber;
  DateTime orderTime;
  bool delivered;
  bool cancelled;
  String dbuttonText;
  String cbuttonText;
  String kotbuttonText;
  bool kotprinted;
  bool subtotalUpdated;
  bool subtotalDecreased;
  bool orderAccepted;
  bool acceptbuttonpressed;
  bool decreasepricetoggle;
  bool billprinted;
  Order({
    required this.tableNumber,
    required this.ordernumber,
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.orderTime,
    this.delivered = false,
    this.billprinted = false,
    this.orderAccepted = false,
    this.kotprinted = false,
    this.cancelled = false,
    this.subtotalUpdated = false,
    this.subtotalDecreased = false,
    this.acceptbuttonpressed = false,
    this.decreasepricetoggle = false,
  })  : dbuttonText = delivered ? 'Accepted' : 'Accept',
        kotbuttonText = billprinted ? 'KOT Printed' : 'Print KOT',
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
