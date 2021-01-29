import 'package:comparare_app/models/productData.dart';
import 'package:comparare_app/services/precos.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Query extends StatefulWidget {
  String _code;
  var service = new PrecosService();
  Query(String code) {
    this._code = code;
  }

  @override
  _QueryState createState() => _QueryState();
}

class _QueryState extends State<Query> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var textControl = TextEditingController();

  bool searching = false;
  String errr = "";

  _QueryState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: Icon(Icons.menu),
        leading: FlatButton(
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Text('Comparare'),
        actions: [],
      ),
      body: Container(
        // alignment: Alignment.center,
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Código de barras",
                  labelStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
                controller: textControl..text = widget._code,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              child: searching
                  ? Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 12,
                        ),
                        Text("Por favor, aguarde")
                      ],
                    )
                  : RaisedButton(
                      onPressed: () => {
                        setState(() => searching = true),
                        widget.service
                            .scanBarCode(textControl.text) //798546846216
                            .then((value) => {
                                  setState(() => searching = false),
                                  if (value != null)
                                    {
                                      Navigator.pop<ProductData>(
                                          context, ProductData.fromJson(value)),
                                    },
                                  setState(
                                      () => errr = "Nenhum produto encontrado"),
                                })
                            .catchError((err) {
                          print(err);
                          setState(() => {
                                searching = false,
                                errr = "Ocorreu um erro interno."
                              });
                        }),
                      },
                      child: Text("Buscar"),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
            ),
            Text(errr),
          ],
        ),
      ),
    );
  }
}
