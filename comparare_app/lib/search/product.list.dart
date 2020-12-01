import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'product.card.dart';
import 'product.card.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      padding: EdgeInsets.all(6),
        child: Wrap(
      runSpacing: 12,
      children: [
        Text(
          "Lista de comparação",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        Wrap(
          runSpacing: 6,
          children: [
            ProductCard(),
            ProductCard(),
            ProductCard(),
            ProductCard(),
            ProductCard(),
          ],
        ),
      ],
    ));
  }
}
