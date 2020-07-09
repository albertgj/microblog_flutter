import 'package:flutter/material.dart';
import 'package:microblog/view/LoginView.dart';
import 'package:microblog/view/MainView.dart';
import 'package:microblog/view/PostDetail.dart';

class Router {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());
        break;
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
        break;
      case 'post':
        return MaterialPageRoute(builder: (_) => PostDetail());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("There is no route for '${settings.name}'"),
            ),
          );
        });
    }
  }
}
