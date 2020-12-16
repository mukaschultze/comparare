import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String barcode;
  Desc desc;
  String image;
  String nome;
  List<Prices> prices;

  ProductData(
      {this.id, this.barcode, this.desc, this.image, this.nome, this.prices});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barcode = json['barcode'];
    desc = json['desc'] != null ? new Desc.fromJson(json['desc']) : null;
    image = json['image'];
    nome = json['nome'];
    if (json['prices'] != null) {
      prices = new List<Prices>();
      json['prices'].forEach((v) {
        prices.add(new Prices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barcode'] = this.barcode;
    if (this.desc != null) {
      data['desc'] = this.desc.toJson();
    }
    data['image'] = this.image;
    data['nome'] = this.nome;
    if (this.prices != null) {
      data['prices'] = this.prices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  String quant;
  String unit;

  Desc({this.quant, this.unit});

  Desc.fromJson(Map<String, dynamic> json) {
    quant = json['quant'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quant'] = this.quant;
    data['unit'] = this.unit;
    return data;
  }
}

class Prices {
  bool isPromo;
  double price;
  String mercadoName;
  String mercadoId;
  int update;

  Prices(
      {this.isPromo,
      this.price,
      this.mercadoName,
      this.mercadoId,
      this.update});

  Prices.fromJson(Map<String, dynamic> json) {
    isPromo = json['isPromo'];
    price = json['price'];
    mercadoName = json['mercadoName'];
    mercadoId = json['mercadoId'];
    update =  json['update'] is Timestamp ?  json['update'].millisecondsSinceEpoch : json['update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPromo'] = this.isPromo;
    data['price'] = this.price;
    data['mercadoName'] = this.mercadoName;
    data['mercadoId'] = this.mercadoId;
    data['update'] = this.update;
    return data;
  }
}
