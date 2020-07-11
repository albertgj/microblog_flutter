import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:microblog/model/Post.dart';

import '../model/Comments.dart';

class Api {
  static const url = 'http://192.168.1.149:8080/api/v2/';

  Future<List<Post>> findAllPosts() async {
    final response = await http.get(url + 'posts');
    Iterable l = json.decode(response.body)['body']['response'];
    List<Post> posts = l.map((model) => Post.fromJson(model)).toList();

    return posts;
  }

  Future<List<Comment>> findCommentsOfPost(int id) async {
    final response = await http.get(url + 'posts/$id/comments');
    Iterable l = json.decode(response.body)['body']['response'];
    List<Comment> commenti = l.map((model) => Comment.fromJson(model)).toList();

    return commenti;
  }

  Future<Post> savePost(Post p, String token) async {
    print(p.data + " " + p.user.id.toString() + " " + p.user.username);

    final response = await http.post(
      url + "posts",
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer " + token
      },
      body: json.encode(p.toJson()),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['body']['response'];
    }
    return null;
  }
}
