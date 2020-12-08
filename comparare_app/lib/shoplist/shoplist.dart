import 'dart:convert';

import 'package:comparare_app/models/core.dart';
import 'package:comparare_app/search/product.card.dart';
import 'package:comparare_app/search/search.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopList extends StatefulWidget {
  List<Product> shoplist;

  ShopList() {
    shoplist = [];
  }

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("data");

    if (data != null) {
      Iterable decode = jsonDecode(data);
      List<Product> result = decode.map((e) => Product.fromJson(e)).toList();
      setState(() {
        widget.shoplist = result;
      });
    }
  }

  _ShopListState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: Icon(Icons.menu),
        leading: FlatButton(
          child: Icon(
            Icons.arrow_left_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
        ),
        title: Text('Lista de Compras'),
        actions: [],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(6),
        child: ListView.builder(
          itemCount: widget.shoplist.length,
          itemBuilder: (context, index) {
            final item = widget.shoplist[index];
            return Wrap(
              children: [
                ProductCard(item),
                SizedBox(height: 6, width: 12),
              ],
            );
          },
        ),
      ),
    );
  }
}
