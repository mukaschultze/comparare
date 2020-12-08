import 'dart:convert';

import 'package:comparare_app/models/core.dart';
import 'package:comparare_app/models/productData.dart';
import 'package:comparare_app/search/product.list.dart';
import 'package:comparare_app/search/query.page.dart';
import 'package:comparare_app/search/sideDrawer.dart';
import 'package:comparare_app/shoplist/shoplist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'product.list.dart';

class SearchPage extends StatefulWidget {
  ProductData data = new ProductData();

  // SearchPage([var list]);
  // SearchPage.c1(var list) {}

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: Icon(Icons.menu),
        leading: FlatButton(
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Text('Comparare'),
        actions: [
          FlatButton(
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ShopList()));
            },
          ),
        ],
      ),
      body: Body(),
      drawer: SideDrawer(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        runSpacing: 36,
        alignment: WrapAlignment.center,
        children: [
          SizedBox(
            height: 1,
            width: MediaQuery.of(context).size.width,
          ),
          ScanBox(),
        ],
      ),
    );
  }
}

class ScanBox extends StatefulWidget {
  ProductData data = new ProductData();

  @override
  _ScanBoxState createState() => _ScanBoxState();
}

class _ScanBoxState extends State<ScanBox> {
  Future _scan() async {
    FlutterBarcodeScanner.scanBarcode(
            "#ff0000", "Digitar", true, ScanMode.BARCODE)
        .then(
      (value) => setState(
        () async => await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Query(value != "-1" ? value : ""),
          ),
        ).then((value) => {
          setState(() => {
            widget.data = ProductData.fromJson(value),
          })
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Busque os melhores preços",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          RaisedButton(
            onPressed: () => _scan(),
            color: Colors.blue,
            textColor: Colors.white,
            child: Text(
              "Buscar",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          ProductList(widget.data),
        ],
      ),
    );
  }
}
