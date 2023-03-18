import 'dart:ffi';

class billdetails {
  String name = "";
  String dateTime = "";
  late List<itemdetails> items = List.empty();
  int total = 0;
}

class itemdetails {
  String itemname = "";
  double qty = 0.0;
  int price = 0;
}
