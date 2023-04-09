// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

class itemModel {
  String itemName;
  double itemQty;
  double itemPrice;
  double? total;
  itemModel({
    required this.itemName,
    required this.itemQty,
    required this.itemPrice,
    this.total=0
  });
  void setPrice(){
    this.total=this.itemQty*this.itemPrice;
  }
}
