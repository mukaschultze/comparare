import 'package:comparare_app/models/mercado.model.dart';
import 'package:comparare_app/models/productData.dart';
import 'package:comparare_app/services/precos.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class CadProd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
      appBar: AppBar(
        // leading: Icon(Icons.menu),
        title: Text('Comparare'),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var barcode = TextEditingController();
  var name = TextEditingController();
  var price = TextEditingController();
  var unit = TextEditingController();
  var quant = TextEditingController();

  List<Mercado> mercados = [];
  var service = new PrecosService();
  List<String> nomes = [];
  Mercado selectedMercado;
  String currentText = "";

  String dropdownValue = 'Unidade';
  String _currentSelectedValue;
  var _units = ["Peso", "Unidade"];

  var mask = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: '.', thousandSeparator: ',');

  GlobalKey<AutoCompleteTextFieldState<String>> keyAuto = new GlobalKey();

  bool searchingProduct = false;
  String searchingString = "Buscando produto...";
  ProductData product = new ProductData();

  Future _scan() async {
    FlutterBarcodeScanner.scanBarcode(
            "#ff0000", "Digitar", true, ScanMode.BARCODE)
        .then(
      (value) => setState(() =>
          {value == '-1' ? this.barcode.text = '' : this.barcode.text = value}),
    );
  }

  _BodyState() {
    service.getAllMercados().then((value) => {
          value.forEach((element) {
            mercados
                .add(new Mercado(id: element.id, nome: element.data()["nome"]));
          }),
          mercados.forEach((e) {
            nomes.add(e.nome);
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36),
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Text(
                "Cadastro de preços",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Focus(
                child: TextField(
                  controller: barcode,
                  decoration: InputDecoration(
                      labelText: "Código de barras",
                      hintText: "154698479651",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () => {_scan()},
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
                onFocusChange: (hasFocus) {
                  if (!hasFocus &&
                      barcode.text != "" &&
                      barcode.text != product.barcode) {
                    setState(() {
                      searchingProduct = true;
                    });
                    service
                        .scanBarCode(barcode.text)
                        .then((value) => {
                              if (value != null)
                                {
                                  setState(() {
                                    searchingProduct = false;
                                    product = ProductData.fromJson(value);
                                    _currentSelectedValue = product.desc.unit;
                                    if (selectedMercado != null &&
                                        product.prices != null) {
                                      var preco = product.prices
                                          .firstWhere(
                                              (element) =>
                                                  element.mercadoId ==
                                                  selectedMercado.id,
                                              orElse: null)
                                          .price;
                                      mask.updateValue(
                                          preco != null ? preco : 0.0);
                                    }
                                  })
                                }
                              else
                                {
                                  setState(() {
                                    product = new ProductData();
                                    searchingString =
                                        "Cadastre um novo produto";
                                    name.text = "";
                                  })
                                }
                            })
                        .catchError(
                          (onError) => {searchingString = onError.message},
                        );
                  }
                },
              ),
              if (searchingProduct) Text(searchingString),
              SizedBox(
                height: 6,
              ),
              SimpleAutoCompleteTextField(
                key: keyAuto,
                suggestions: nomes,
                decoration: InputDecoration(
                  labelText: "Mercado",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.store),
                    onPressed: () {},
                  ),
                ),
                textSubmitted: (text) {
                  selectedMercado =
                      mercados.firstWhere((element) => element.nome == text);
                },
                textChanged: (text) => currentText = text,
                clearOnSubmit: false,
              ),
              TextField(
                controller: name..text = product.nome,
                decoration: InputDecoration(
                    labelText: "Nome do produto",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.ballot),
                    )),
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Unidade de medida",
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      hintText: 'Selecione a Unidade do produto',
                    ),
                    isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentSelectedValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentSelectedValue = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _units.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              TextField(
                controller: quant
                  ..text = product.desc != null ? product.desc.quant : "",
                decoration: InputDecoration(
                    labelText: "Quantidade",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                    )),
              ),
              TextField(
                controller: mask,
                decoration: InputDecoration(
                    labelText: "Preço",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.monetization_on),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                onPressed: () => {},
                child: Text("Salvar"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
