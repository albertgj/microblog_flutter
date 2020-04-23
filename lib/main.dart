import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/view/LoginPage.dart';
import 'package:microblog/view/MainView.dart';

void setupLocator() {

}


void main() {
  final storage = FlutterSecureStorage();

  setupLocator();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: storage.read(key: "jwt") == null ? LoginPage() : MyApp(),
    ),
  );
}
