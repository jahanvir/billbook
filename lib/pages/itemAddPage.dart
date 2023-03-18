import 'package:billbook/pages/printPage.dart';
import 'package:flutter/material.dart';
import 'itemModel.dart';

class itemAddPage extends StatefulWidget {
  _itemAddPage createState() => _itemAddPage();
}

class _itemAddPage extends State<itemAddPage> {
  List<itemModel> items = List.empty(growable: true);

  final itemName = TextEditingController();
  final itemQty = TextEditingController();

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 30,
    ),
  );

  Widget BodyCard(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 800,
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
                    icon: Icon(Icons.people),
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
                    icon: Icon(Icons.people),
                    hintText: "Enter item quantity",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    printPage(itemHolder: items)));
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
                      onPressed: () {
                        itemModel temp = itemModel(
                            itemName: itemName.text,
                            itemQty: double.parse(itemQty.text));
                        items.add(temp);
                      },
                      child: const Text("Add")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Print bill"),
        ),
        body: BodyCard(context));
  }
}
