import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:microblog/model/Post.dart';

class PostApiProvider {
  static const url = 'http://192.168.1.149:8080/api/v2/posts/';

  Future<List<Post>> findAllPosts() async {
    final response = await http.get(url);
    Iterable cazzi = json.decode(response.body);
    List<Post> posts = cazzi.map((model) => Post.fromJson(model)).toList();
    return posts;
  }
}
