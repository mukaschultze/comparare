import 'package:comparare_app/models/productData.dart';

class Product {
  String id;
  String barcode;
  String name;
  Desc desc;
  String image;
  Prices preco;

  Product({this.id, this.barcode, this.name, this.desc, this.preco, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barcode = json['barcode'];
    name = json['name'];
    image = json['image'];
    desc = json['desc'] != null ? new Desc.fromJson(json['desc']) : null;
    preco = json['preco'] != null ? new Prices.fromJson(json['preco']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barcode'] = this.barcode;
    data['name'] = this.name;
    data['image'] = this.name;
    if (this.desc != null) {
      data['desc'] = this.desc.toJson();
    }
    if (this.preco != null) {
      data['preco'] = this.preco.toJson();
    }
    return data;
  }
}

