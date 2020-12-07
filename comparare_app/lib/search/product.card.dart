import 'package:comparare_app/models/core.dart';
import 'package:comparare_app/search/product.list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  Product product;

  ProductCard(Product product) {
    this.product = product;
  }

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final formatCurrency = new NumberFormat.currency(
      locale: "pt_BR", name: "BRL", decimalDigits: 2, symbol: "R\$");

  String formataHora(String timestamp) {
    return new DateFormat("d/MM/y H:m:s").format(
        new DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000)
            .toLocal());
  }

  @override
  Widget build(BuildContext context) {
    Product data = widget.product;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      height: 85,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        direction: Axis.horizontal,
        spacing: 12,
        children: [
          SizedBox(
            // BOX DA IMAGEM DO PRODUTO
            height: 85,
            width: 85,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
            ),
          ),
          Wrap(
            spacing: 3,
            direction: Axis.vertical,
            children: [
              SizedBox(
                width: 1,
                height: 1,
              ),
              Text(
                // Mercado text
                data.preco.mercadoID,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                data.name,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                formatCurrency.format(data.preco.preco),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                // 'Atualizado: 26/11/2020 20:30',
                formataHora(data.preco.upadate),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Container(
            // alignment: Alignment.center,
            // color: Colors.red,

            child: Material(
              color: Colors.white,

              child: IconButton(

                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _ProductListState list = new _ProductCardState();
                  list.addToShopList(data);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
