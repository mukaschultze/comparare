class Product {
  String id;
  String barcode;
  String name;
  Desc desc;
  Preco preco;

  Product({this.id, this.barcode, this.name, this.desc, this.preco});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barcode = json['barcode'];
    name = json['name'];
    desc = json['desc'] != null ? new Desc.fromJson(json['desc']) : null;
    preco = json['preco'] != null ? new Preco.fromJson(json['preco']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barcode'] = this.barcode;
    data['name'] = this.name;
    if (this.desc != null) {
      data['desc'] = this.desc.toJson();
    }
    if (this.preco != null) {
      data['preco'] = this.preco.toJson();
    }
    return data;
  }
}

class Desc {
  String quant;
  String uint;

  Desc({this.quant, this.uint});

  Desc.fromJson(Map<String, dynamic> json) {
    quant = json['quant'];
    uint = json['uint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quant'] = this.quant;
    data['uint'] = this.uint;
    return data;
  }
}

class Preco {
  String id;
  String mercadoID;
  bool isPromo;
  double preco;
  String upadate;
  String productID;

  Preco(
      {this.id,
      this.mercadoID,
      this.isPromo,
      this.preco,
      this.upadate,
      this.productID});

  Preco.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mercadoID = json['mercadoID'];
    isPromo = json['isPromo'];
    preco = json['preco'];
    upadate = json['upadate'];
    productID = json['productID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mercadoID'] = this.mercadoID;
    data['isPromo'] = this.isPromo;
    data['preco'] = this.preco;
    data['upadate'] = this.upadate;
    data['productID'] = this.productID;
    return data;
  }
}
