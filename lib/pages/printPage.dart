// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'itemModel.dart';

class printPage extends StatefulWidget {
  final List<itemModel> itemHolder;

  const printPage({super.key, required this.itemHolder});
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
  static GlobalKey _globalKey = GlobalKey();

  void initState() {
    button = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    itemModel items = widget.itemHolder.first;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Print bill"),
        ),
        body: BodyCard(context));
    /* body: RepaintBoundary(
          child: BodyCard(context),
        )); */
    throw UnimplementedError();
  }

  Widget BodyCard(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            color: Colors.orange[100],
            elevation: 10,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    style: TextStyle(fontSize: 30),
                    readOnly: true,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: 160,
                  margin: EdgeInsets.only(left: 240.0, right: 10),
                  child: TextField(
                    readOnly: true,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 26.0, left: 18.0, right: 18.0),
                  child: Table(
                      border: TableBorder.all(color: Colors.orange),
                      children: [
                        TableRow(children: [
                          Text(
                            '${widget.itemHolder.first.itemName}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text('${widget.itemHolder.first.itemQty}'),
                          Text("price")
                        ]),
                        TableRow(children: [
                          Text("item name"),
                          Text("quantity"),
                          Text("price")
                        ])
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
