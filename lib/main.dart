import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:microblog/Locator.dart';
import 'package:microblog/MyTest.dart';
import 'package:microblog/Router.dart';
import 'package:microblog/view/MainView.dart';

void main() {
  //final storage = FlutterSecureStorage();
  //storage.read(key: "jwt") == null ? LoginPage() :
  setupLocator();
  runApp(
    MaterialApp(
      title: 'MicroBlog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/',
      onGenerateRoute: Router.generatedRoute,
      home: MyApp(),
    ),
  );
}
