import 'dart:convert';

import 'package:microblog/model/Comments.dart';
import 'package:microblog/model/Post.dart';
import 'package:microblog/services/API.dart';
import 'package:http/http.dart' as http;

class PostService {
  static const url = 'url';

  Future<API<List<Post>>> findAllPosts() async {
    return http.get(url + 'posts/').then((data) {
      var posts = List<Post>();

      if (data.statusCode == 200) {
        Iterable list = json.decode(data.body);
        posts = list.map((model) => Post.fromJson(model)).toList();
        return API<List<Post>>(data: posts);
      } else {
        return API<List<Post>>(error: true, errorMessage: "Not Found");
      }
    }).catchError(
        (_) => API<List<Post>>(error: true, errorMessage: "Not Found"));
  }

  Future<API<List<Comment>>> findCommentsOfPost(int id) async {
    return http.get(url + 'posts/commenti/' + id.toString()).then((data) {
      var comments = List<Comment>();

      if (data.statusCode == 200) {
        Iterable list = json.decode(data.body);
        comments = list.map((model) => Comment.fromJson(model)).toList();
        return API<List<Comment>>(data: comments);
      } else {
        return API<List<Comment>>(error: true, errorMessage: "Not Found");
      }
    }).catchError(
        (_) => API<List<Comment>>(error: true, errorMessage: "Not Found"));
  }

  Future<API<String>> savePost(Post p) async {
    return http
        .post(url + 'posts/',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: json.encode(p))
        .then(
      (data) {
        return API<String>(data: data.body);
      },
    );
  }

  Future<API<String>> saveComment(Comment c) async {
    return http
        .post(url + 'commenti/',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: json.encode(c))
        .then(
      (data) {
        return API<String>(data: data.body);
      },
    );
  }
}
