import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:microblog/view/BaseView.dart';
import 'package:microblog/viewmodel/LoginModel.dart';
import 'package:microblog/viewmodel/ViewState.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Key _k1 = new GlobalKey();
  Key _k2 = new GlobalKey();
  final storage = FlutterSecureStorage();
  TextEditingController username;
  TextEditingController password;

  @override
  void initState() {
    username = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: username,
      key: _k1,
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
      key: _k2,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
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
            model.state == ViewState.Busy
                ? CircularProgressIndicator()
                : Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () async {
                        var login =
                            await model.login(username.text, password.text);
                        if (login) {
                          Navigator.pushNamed(context, '/');
                        } else {
                          print(login);
                        }
                      },
                      child: Text("Login",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: GestureDetector(
                  child: Text("Non sei ancora iscritto? Registrati subito"),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => null));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
