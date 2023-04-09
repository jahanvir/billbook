import 'package:billbook/module/billdetails.dart';
import 'package:billbook/pages/billModel.dart';
import 'package:billbook/pages/printPage.dart';
import 'package:flutter/material.dart';
import 'itemModel.dart';

class itemAddPage extends StatefulWidget {


  const itemAddPage({super.key, required this.billDetails});
  final billModel billDetails;
  _itemAddPage createState() => _itemAddPage();
}

class _itemAddPage extends State<itemAddPage> {
  List<itemModel> items = List.empty(growable: true);

  final itemName = TextEditingController();
  final itemQty = TextEditingController();
  final itemPrice= TextEditingController();
  bool buttonEnabled= false;
  int itemCount=0;
  bool itemFull=false;

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 30,
    ),
  );

  Widget BodyCard(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 500,
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            color: Colors.orange[100],
            elevation: 10,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(26.0),
                  child: TextField(
                    controller: itemName,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                      icon: Icon(Icons.food_bank),
                      hintText: "Enter item name",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(26.0),
                  child: TextField(
                    controller: itemQty,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                      icon: Icon(Icons.monitor_weight_rounded),
                      hintText: "Enter item quantity",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(26.0),
                  child: TextField(
                    controller: itemPrice,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                      icon: Icon(Icons.currency_rupee),
                      hintText: "Enter price",
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: style,
                            onPressed: buttonEnabled?() {
                              widget.billDetails.items=items;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          printPage(itemHolder: items,billDetails: widget.billDetails,)));
                            }:(){
                              showDialog(context: context, builder: (BuildContext context){
                                return new AlertDialog(
                                  title: new Text("Add items"),
                                  backgroundColor: Colors.orange[100],
                                );
                              });
                            },
                            child: const Text("Next")),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: style,
                            onPressed: !itemFull?() {
                              if(itemName.text == '' || itemQty.text =='' || itemPrice.text =='' ){
                                showDialog(context: context, builder: (BuildContext context){
                                  return new AlertDialog(
                                    title: new Text("Fill all the fields"),
                                    backgroundColor: Colors.blue[100],
                                  );
                                });
                              }
                              else{
                              itemModel temp = itemModel(
                                  itemName: itemName.text,
                                  itemQty: double.parse(itemQty.text),
                                  itemPrice: double.parse(itemPrice.text),
                              );
                              setState(() {
                                buttonEnabled=true;
                                itemCount+=1;
                                if(itemCount >5){
                                  itemFull=true;
                                }
                              });
                              temp.setPrice();
                              items.add(temp);
                              itemQty.clear();
                              itemPrice.clear();
                              itemName.clear();
                              showDialog(context: context, builder: (BuildContext context){
                                return new AlertDialog(
                                  title: new Text("Item is added"),
                                  backgroundColor: Colors.orange[300],
                                );
                              });
                            }}:(){
                              showDialog(context: context, builder: (BuildContext context){
                                return new AlertDialog(
                                  title: new Text("Item List is Full"),
                                  backgroundColor: Colors.red[100],
                                );
                              });
                            },
                            child: const Text("Add")),
                      ),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    billModel billDetails = widget.billDetails;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Print bill"),
        ),
        body: BodyCard(context));
  }
}
