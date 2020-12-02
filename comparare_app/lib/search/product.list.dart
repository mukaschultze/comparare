import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'product.card.dart';
import 'product.card.dart';

class ProductList extends StatelessWidget {
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
              child: true
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
                        ProductCard(),
                        ProductCard(),
                        ProductCard(),
                        ProductCard(),
                        ProductCard(),
                      ],
                    ),
            ),
          ],
        ));
  }
}
