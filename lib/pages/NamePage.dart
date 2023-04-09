import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'billModel.dart';
import 'itemAddPage.dart';
import 'printPage.dart';
import '../module/billdetails.dart';

class NamePage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _NamePage();
  }
}

class _NamePage extends State<NamePage> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  billModel bill = billModel();
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 30,
    ),
  );

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

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
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(26.0),
                child: TextField(
                  controller: nameInput,
                  style: TextStyle(fontSize: 30),
                  decoration: InputDecoration(
                    icon: Icon(Icons.people),
                    hintText: "Enter name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(26.0),
                child: TextField(
                  controller: dateInput,
                  style: const TextStyle(fontSize: 30),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      hintText: "Select date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      String formateDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      //print(pickedDate);
                      setState(() {
                        dateInput.text = formateDate;
                        bill.date = formateDate;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        bill.custName = nameInput.text;
                        bill.date=dateInput.text;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => itemAddPage(billDetails: bill)));
                      },
                      child: const Text("Next")),
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Print bill"),
        ),
        body: BodyCard(context));
  }
}
