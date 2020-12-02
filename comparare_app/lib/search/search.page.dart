import 'package:comparare_app/search/product.list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'product.list.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [],
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Wrap(
    //     direction: Axis.vertical,
    //     spacing: 6,
    //     children: [
    //       ScanBox(),
    //       ProductList(),
    //     ],
    //   ),
    // );
    // return Column(
    //     children: ListView(
    //   scrollDirection: Axis.vertical,
    //   children: [
    //     ScanBox(),
    //     ProductList(),
    //   ],
    // ));
    return Container(
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
          ProductList(),
        ],
      ),
    );
  }
}

class ScanBox extends StatefulWidget {
  @override
  _ScanBoxState createState() => _ScanBoxState();
}

class _ScanBoxState extends State<ScanBox> {
  String _data = "";

  Future<String> _scan() async {
    FlutterBarcodeScanner.scanBarcode("#ff0000", "Cancelar", false, ScanMode.BARCODE).then((value) => setState(()=> _data = value));
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
            onPressed: ()=> _scan(),
            color: Colors.blue,
            textColor: Colors.white,
            child: Text(
              "Escanear",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Text(_data),
        ],
      ),
    );
  }
}
