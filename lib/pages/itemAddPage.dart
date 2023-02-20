import 'package:flutter/material.dart';

class itemAddPage extends StatelessWidget {
  Widget BodyCard(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 400,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.orange[100],
          elevation: 10,
          child: Column(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(26.0),
                child: TextField(
                  style: TextStyle(fontSize: 30),
                  decoration: InputDecoration(
                    icon: Icon(Icons.people),
                    hintText: "Enter name",
                  ),
                ),
              ),
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
