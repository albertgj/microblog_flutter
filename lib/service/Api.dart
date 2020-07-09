import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:microblog/model/Post.dart';

class Api {
  static const url = 'http://192.168.1.149:8080/api/v2/';

  Future findAllPosts() async {
    final response = await http.get(url + 'posts');
    Iterable l = json.decode(response.body)['body']['response'];
    List<Post> posts = l.map((model) => Post.fromJson(model)).toList();

    return posts;
  }
}
