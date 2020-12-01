import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                'Nome do mercado',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Nome do produto vem aqui.',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'R\$ 14,99',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Atualizado: 26/11/2020 20:30',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
