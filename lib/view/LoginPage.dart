import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:microblog/blocs/LoginBloc.dart';
import 'package:microblog/blocs/PostBloc.dart';
import 'package:microblog/view/MainView.dart';
import 'package:microblog/view/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final storage = FlutterSecureStorage();
  TextEditingController username;
  TextEditingController password;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    //loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: username,
      key: UniqueKey(),
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      controller: password,
      key: UniqueKey(),
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          loginBloc.loginUser(username.text, password.text);

          loginBloc.authenticateUser;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 120, right: 20, left: 20),
        children: <Widget>[
          Center(
            child: Text(
              "LOGIN MICROBLOG",
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          emailField,
          SizedBox(
            height: 20,
          ),
          passwordField,
          SizedBox(
            height: 20,
          ),
          loginButton,
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: GestureDetector(
                child: Text("Non sei ancora iscritto? Registrati subito"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage())
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
