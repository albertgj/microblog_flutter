import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:microblog/model/Post.dart';

import '../model/Comments.dart';

class Api {
  static const url = 'http://192.168.1.149:8080/api/v2/';

  Future findAllPosts() async {
    final response = await http.get(url + 'posts');
    Iterable l = json.decode(response.body)['body']['response'];
    List<Post> posts = l.map((model) => Post.fromJson(model)).toList();

    return posts;
  }

  Future findCommentsOfPost(int id) async {
    final response = await http.get(url + 'posts/$id' + '/comments');
    Iterable l = json.decode(response.body)['body']['response'];
    List<Comment> commenti = l.map((model) => Comment.fromJson(model)).toList();

    return commenti;
  }
}
