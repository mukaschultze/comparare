import 'package:comparare_app/login/login.dart';
import 'package:comparare_app/search/search.page.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool logged = false;
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.only(top: 24, left: 12),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Container(
                    color: Colors.red,
                    child: Text("AQUI VAI O LOGO"),
                  ),
                ),
                Text(
                  'Comparare',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Compares e encontre os melhores preços.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Buscar Produtos'),
            onTap: () { 
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
          ListTile(
            title: Text('Lista de Compras'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          if (logged)
            ListTile(
              title: Text('Cadastrar um produto'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          logged ? 
          ListTile(
            title: Text('Sair'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ) : 
          ListTile(
            title: Text('Fazer login'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
