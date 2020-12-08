import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/core.dart';

import 'product.card.dart';
import 'product.card.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.white,
        padding: EdgeInsets.all(6),
        child: Wrap(
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            Text(
              "Lista de comparação",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: false
                  ? Column(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Image(
                          image: AssetImage('resource/empty.png'),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                        ),
                        Text(
                          "Pesquise para comparar",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "Lista de comparação está vazia",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  : Wrap(
                      runSpacing: 6,
                      children: [
                        ProductCard(new Product(
                          barcode: "7951621",
                          id: "123",
                          name: "Molho de Tomate",
                          desc: new Desc(quant: "1", uint: "Unidade"),
                          preco: new Preco(
                              id: "123",
                              isPromo: false,
                              mercadoID: "ID - NOME MERCADO",
                              preco: 1.20,
                              productID: "123",
                              upadate: "1607363921 "),
                        )),
                        ProductCard(new Product(
                          barcode: "69875131",
                          id: "123",
                          name: "Carne Moida",
                          desc: new Desc(quant: "1", uint: "Unidade"),
                          preco: new Preco(
                              id: "123",
                              isPromo: false,
                              mercadoID: "ID - NOME MERCADO",
                              preco: 1.20,
                              productID: "123",
                              upadate: "1607363921 "),
                        )),
                        ProductCard(new Product(
                          barcode: "12371837",
                          id: "123",
                          name: "Molho de Tomate",
                          desc: new Desc(quant: "1", uint: "Unidade"),
                          preco: new Preco(
                              id: "123",
                              isPromo: false,
                              mercadoID: "ID - NOME MERCADO",
                              preco: 1.20,
                              productID: "123",
                              upadate: "1607363921 "),
                        )),
                        // ProductCard(),
                        // ProductCard(),
                        // ProductCard(),
                        // ProductCard(),
                      ],
                    ),
            ),
          ],
        ));
  }
}
