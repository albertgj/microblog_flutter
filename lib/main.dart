import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:microblog/Locator.dart';
import 'package:microblog/MyTest.dart';
import 'package:microblog/Router.dart';
import 'package:microblog/view/HomeView.dart';

void main() {
  setupLocator();
  runApp(
    MaterialApp(
      title: 'MicroBlog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: Router.generatedRoute,
      home: HomeView(),
    ),
  );
}
