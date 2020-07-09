import 'package:flutter/material.dart';
import 'package:microblog/view/LoginView.dart';
import 'package:microblog/view/HomeView.dart';
import 'package:microblog/view/CommentView.dart';

import 'model/Post.dart';

class Router {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
        break;
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
        break;
      case 'post':
        var post = settings.arguments as Post;
        return MaterialPageRoute(
          builder: (_) => CommentView(
            id: post.id,
            data: post.data,
            text: post.text,
            titolo: post.titolo,
            user: post.user,
          ),
        );
        break;
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
