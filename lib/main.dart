import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/services/CommentService.dart';
import 'package:microblog/services/PersonaService.dart';
import 'package:microblog/services/PostService.dart';
import 'package:microblog/view/MainView.dart';
import 'package:microblog/resources/PostApiProvider.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton<PersonaService>(() => PersonaService());
  GetIt.I.registerLazySingleton<CommentService>(() => CommentService());
  GetIt.I.registerLazySingleton<PostService>(() => PostService());
}

void main() {
  setupLocator();
  final merda = PostApiProvider();
  merda.findAllPosts();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyApp(),
    ),
  );
}
