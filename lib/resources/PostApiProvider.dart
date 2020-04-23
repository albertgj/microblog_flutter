import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:microblog/model/Comments.dart';
import 'package:microblog/model/Post.dart';

class PostApiProvider {
  static const url = 'http://192.168.1.223:8080/api/v2/posts/';
  final storage = FlutterSecureStorage();

  Future<List<Post>> findAllPosts() async {
    String s = await storage.read(key: "jwt");
    final response =
        await http.get(url, headers: {"Authorization": 'Bearer ' + s});
    Iterable l = json.decode(response.body);
    List<Post> posts = l.map((model) => Post.fromJson(model)).toList();
    return posts;
  }

  Future<List<Comment>> findAllCommentsOfPost(int id) async {
    String s = await storage.read(key: "jwt");
    final response = await http.get(url + 'commenti/' + id.toString(),
        headers: {"Authorization": 'Bearer ' + s});
    Iterable l = json.decode(response.body);
    List<Comment> commenti = l.map((model) => Comment.fromJson(model)).toList();

    return commenti;
  }

  Future<Post> savePost(Post p) async {
    String s = await storage.read(key: "jwt");

    final response = await http.post(
      url,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer " + s
      },
      body: json.encode(p.toJson()),
    );
    print(p.toJson());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> deletePosts(int id) async {
    final response = await http.delete(url + '$id');
    var test = response.body;
    print(test);
    return json.decode(test);
  }
}
