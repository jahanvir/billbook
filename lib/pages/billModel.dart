// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'itemModel.dart';

class billModel {
  String custName;
  String date;
  List<itemModel> items;
  billModel({
    required this.custName,
    required this.date,
    required this.items,
  });
}
