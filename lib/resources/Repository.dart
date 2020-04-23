import 'package:microblog/model/Comments.dart';
import 'package:microblog/model/Post.dart';
import 'package:microblog/resources/JwtApiProvider.dart';
import 'package:microblog/resources/PostApiProvider.dart';

class Repository {
  final postApiProvider = PostApiProvider();
  final jwtApiProvider = JwtApiProvider();
  
  Future<List<Post>> fetchAllPosts() => postApiProvider.findAllPosts();
  Future<Map<String, dynamic>> deletePost(int id) => postApiProvider.deletePosts(id);
  Future<List<Comment>> findAllCommentsOfPost(int id) => postApiProvider.findAllCommentsOfPost(id);
  Future<Post> savePost(Post p) => postApiProvider.savePost(p);

  Future<Map<String, dynamic>> authenticate(String username, String password) => jwtApiProvider.authenticate(username, password);
}