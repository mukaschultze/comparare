import 'package:comparare_app/models/core.dart';
import 'package:comparare_app/models/productData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/core.dart';
import 'product.card.dart';

class ProductList extends StatefulWidget {
  ProductData data = new ProductData();

  ProductList(ProductData data) {
    this.data = data;
  }

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Product convert(ProductData data, int index) {
    return new Product(
        barcode: data.barcode,
        descricao: data.desc != null
            ? new Descricao(quant: data.desc.quant, unit: data.desc.unit)
            : new Descricao(quant: "1", unit: "Unidade"),
        id: data.id,
        image: data.image != null
            ? data.image
            : "https://cdn-cosmos.bluesoft.com.br/products/" + data.barcode,
        name: data.nome,
        preco: new Preco(
          isPromo: data.prices[index].isPromo,
          mercadoId: data.prices[index].mercadoId,
          mercadoName: data.prices[index].mercadoName,
          price: data.prices[index].price,
          update: data.prices[index].update.toString(),
        ));
  }

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
              child: widget.data.barcode == null
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
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(6),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.data.prices.length,
                        itemBuilder: (context, index) {
                          final item = widget.data.prices[index];
                          return Wrap(
                            children: [
                              ProductCard(convert(widget.data, index)),
                              SizedBox(height: 6, width: 12),
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ));
  }
}
