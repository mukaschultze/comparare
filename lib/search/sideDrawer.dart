import 'package:comparare_app/cad_prod/cad_prod.dart';
import 'package:comparare_app/login/login.dart';
import 'package:comparare_app/search/search.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  // FirebaseAuth firebaseAuth = new FirebaseAuth();

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
            padding: EdgeInsets.only(top: 12, left: 12),
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
                ),
                if (FirebaseAuth.instance.currentUser != null)
                  Text(
                    FirebaseAuth.instance.currentUser.displayName != null
                        ? FirebaseAuth.instance.currentUser.displayName
                        : FirebaseAuth.instance.currentUser.email,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
          ListTile(
            title: Text('Lista de Compras'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          if (FirebaseAuth.instance.currentUser != null)
            ListTile(
              title: Text('Cadastrar um produto'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CadProd()));
              },
            ),
          FirebaseAuth.instance.currentUser != null
              ? ListTile(
                  title: Text('Sair'),
                  onTap: () {
                    setState(() {
                      FirebaseAuth.instance.signOut();
                    });
                  },
                )
              : ListTile(
                  title: Text('Fazer login'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
        ],
      ),
    );
  }
}
