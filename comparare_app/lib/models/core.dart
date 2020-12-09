class Product {
  String id;
  String barcode;
  String name;
  Descricao descricao;
  Preco preco;
  String image;

  Product(
      {this.id,
      this.barcode,
      this.name,
      this.descricao,
      this.preco,
      this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barcode = json['barcode'];
    name = json['name'];
    descricao = json['descricao'] != null
        ? new Descricao.fromJson(json['descricao'])
        : null;
    preco = json['preco'] != null ? new Preco.fromJson(json['preco']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barcode'] = this.barcode;
    data['name'] = this.name;
    if (this.descricao != null) {
      data['descricao'] = this.descricao.toJson();
    }
    if (this.preco != null) {
      data['preco'] = this.preco.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Descricao {
  String quant;
  String unit;

  Descricao({this.quant, this.unit});

  Descricao.fromJson(Map<String, dynamic> json) {
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

class Preco {
  bool isPromo;
  double price;
  String mercadoName;
  String mercadoId;
  String update;

  Preco(
      {this.isPromo,
      this.price,
      this.mercadoName,
      this.mercadoId,
      this.update});

  Preco.fromJson(Map<String, dynamic> json) {
    isPromo = json['isPromo'];
    price = json['price'];
    mercadoName = json['mercadoName'];
    mercadoId = json['mercadoId'];
    update = json['update'];
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
