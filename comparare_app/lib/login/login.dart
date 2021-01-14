import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import './login.service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Login",
                ),
                Tab(
                  text: "Registrar-se",
                  // child: Login(),
                ),
              ],
            ),
            title: Text("Comparare"),
          ),
          body: TabBarView(
            children: [Login(), SignUP()],
          ),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  String email = "";
  String password = "";

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
                  "Entrar",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "seu.email@gmail.com",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.email),
                      )),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Senha",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.lock),
                      )),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(
                  onPressed: () =>
                      {LoginService.signInWithEmail(email, password)},
                  child: Text("Entrar"),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "OU",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 12,
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Google",
                  onPressed: () {
                    LoginService.signInWithGoogle();
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Ainda não possui conta? ",
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, "myRoute");
                    DefaultTabController.of(context).animateTo(1);
                  },
                  child: new Text(
                    "Cadastre-se agora",
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class SignUP extends StatefulWidget {
  @override
  State<SignUP> createState() => SignUpState();
}

class SignUpState extends State<SignUP> {
  String email = "";
  String password = "";
  String error = "";

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
                  "Cadastrar-se",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Nome",
                      hintText: "Ex: Maria",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.person),
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "seu.email@gmail.com",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.email),
                      )),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Senha",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.lock),
                      )),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(
                  onPressed: () => {
                    LoginService.signUpWithEmail(email, password).then(
                      (value) => print(value),
                    ).catchError((onError) {
                      setState((){
                        error = onError.message;
                      }); 
                    })
                  },
                  child: Text("Cadastrar"),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Já possui uma conta? ",
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, "myRoute");
                    DefaultTabController.of(context).animateTo(0);
                  },
                  child: new Text(
                    "Conecte-se agora",
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
