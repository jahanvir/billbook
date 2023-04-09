// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:billbook/models/billModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../models/itemModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class printPage extends StatefulWidget {
  final List<itemModel> itemHolder;
  final billModel billDetails;
  const printPage({super.key, required this.itemHolder, required this.billDetails});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _printPage();
    throw UnimplementedError();
  }
}




class _printPage extends State<printPage> {
  bool button = false;
  //itemModel items;
  final _screenshotController = ScreenshotController();
  static GlobalKey _globalKey = GlobalKey();

  void initState() {
    button = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<itemModel> items = widget.itemHolder;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Print bill"),
        ),
        body: BodyCard(context),
        floatingActionButton:FloatingActionButton(onPressed: () async {
          final image= await _screenshotController.capture();
          if (image == null) return;
          await saveImage(image);
          showDialog(context: context, builder: (BuildContext context){
            return new AlertDialog(
              title: new Text("Bill is saved"),
              backgroundColor: Colors.orange[300],
            );
          });
        },
        child: Icon(Icons.download),),
    );
        //FloatingActionButton(onPressed: () {  },);
    /* body: RepaintBoundary(
          child: BodyCard(context),
        )); */



  }
  List<DataRow> getRows(List<itemModel> items){
    final rows = <DataRow>[];
    double totalVal=0.0;
    for (var item in items){
      totalVal+=item.total!;
      rows.add(DataRow(cells: <DataCell>[
        DataCell(Text(item.itemName)),
        DataCell(Text(item.itemQty.toString())),
        DataCell(Text(item.total.toString())),
      ]));
    }
    rows.add(DataRow(cells: <DataCell>[
        DataCell(Text("")),
        DataCell(Text("Total",style: TextStyle(fontWeight: FontWeight.bold),)),
        DataCell(Text(totalVal.toString()))
    ]));
    return rows;
   //  final rows = <DataRow>[];
   //  for (var item in items){
   //    rows.add(DataRow(cells: <DataCell>[
   //      DataCell(Text(item.itemName)),
   //      DataCell(Text(item.itemQty as String)),
   //    ] )
   //
   //   
   // }
  }

  Widget BodyCard(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          //height:
          //width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(minHeight: 0, maxHeight: 600),
          child: Screenshot(
            controller: _screenshotController,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Colors.orange[100],
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(20)),
                  Container(
                    width: 300 ,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3.0,
                          color: Color(0xffcc6906)
                        )
                      )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        widget.billDetails.custName,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                            ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 3.0,
                                    color: Color(0xffcc6906)
                                )
                            )
                        ),
                        margin: EdgeInsets.only(left: 180.0,right: 18),
                        child: Align(
                          child:Text(
                            widget.billDetails.date,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                  //
                  DataTable(
                      columns: const <DataColumn>[
                        DataColumn(label: Expanded(child: Text('Item'))),
                        DataColumn(label: Expanded(child: Text('Quantity'))),
                        DataColumn(label: Expanded(child: Text('Price')))
                      ],
                      rows:getRows(widget.itemHolder)),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = "screenshot_$time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];

  }
}


