import 'package:microblog/model/Post.dart';
import 'package:microblog/resources/PostApiProvider.dart';

class Repository {
  final postApiProvider = PostApiProvider();
  
  Future<List<Post>> fetchAllPosts() => postApiProvider.findAllPosts();
}