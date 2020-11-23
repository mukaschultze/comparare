import 'package:flutter/cupertino.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "Lista de comparação",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        )
      ],
    );
  }
}