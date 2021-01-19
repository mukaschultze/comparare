import 'package:comparare_app/models/mercado.model.dart';
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
  List<Mercado> mercados = [];
  var service = new PrecosService();
  var barcode = TextEditingController();
  List<String> nomes = [];
  Mercado selectedMercado;
  String currentText = "";

  String dropdownValue = 'Unidade';
  String _currentSelectedValue;
  var _units = ["KG", "Unidade"];

  var mask = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: '.', thousandSeparator: ',');

  GlobalKey<AutoCompleteTextFieldState<String>> keyAuto = new GlobalKey();

  bool searchingProduct = false;
  String searchingString = "Buscando produto...";

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
                onFocusChange: (hasFocus){
                  if(!hasFocus && barcode.text != ""){
                    setState(() {
                      searchingProduct = true;
                    });
                      service.scanBarCode(barcode.text).then((value) => {
                        if(value != null){
                          setState((){
                            searchingProduct = false;
                          })
                        }else{
                          setState(() {
                            searchingString = "Cadastre um novo produto";
                          })
                        }
                      }).catchError((onError) => {
                        searchingString = onError.message
                      });
                  }
                },
              ),
              SizedBox(
                height: 6,
              ),
              if(searchingProduct)
              Text(searchingString),
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
                  print(selectedMercado.nome);
                },
                textChanged: (text) => currentText = text,
                clearOnSubmit: false,
              ),
              TextField(
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
                controller: mask,
                decoration: InputDecoration(
                    labelText: "Preço",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.credit_card),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                onPressed: () => {},
                child: Text("Cadastrar"),
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
