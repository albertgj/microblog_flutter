import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MicroBlog"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Text("Hello"),
            FlatButton(
                onPressed: () {

                  http
                      .get('http://192.168.1.149:8080/api/v2/posts')
                      .then((res) => print(json.decode(res.body)))
                      .catchError((error) => print(error));

      
                },
                child: Text("Click Me To retrive"))
          ],
        ),
      ),
    );
  }
}
