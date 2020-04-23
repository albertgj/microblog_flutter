import 'package:microblog/model/Comments.dart';
import 'package:microblog/model/Post.dart';
import 'package:microblog/resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc {
  final _repository = Repository();
  final _postFetcher = PublishSubject<List<Post>>();
  final _postDeleter = PublishSubject<Map<String, dynamic>>();
  final _commentsOfPost = PublishSubject<List<Comment>>();
  final _savePost = PublishSubject<Post>();

  Stream<List<Post>> get allPosts => _postFetcher.stream;
  Stream<Map<String, dynamic>> get deletePost => _postDeleter.stream;
  Stream<List<Comment>> get commentsOfPost => _commentsOfPost.stream;
  Stream<Post> get saveAPost => _savePost.stream;


  fetchAllPosts() async {
    List<Post> post = await _repository.fetchAllPosts();
    _postFetcher.sink.add(post);
  }

  findAllCommentsOfPost(int id) async {
    List<Comment> commenti = await _repository.findAllCommentsOfPost(id);
    _commentsOfPost.sink.add(commenti);
  }

  savePost(Post p) async {
    Post ps = await _repository.savePost(p);
    _savePost.add(ps);
  }

  deletePosts(int id) async {
    Map<String, dynamic> delete = await _repository.deletePost(id);
    _postDeleter.sink.add(delete);
  }

  dispose() {
    _postFetcher.close();
    _postDeleter.close();
    //_commentsOfPost.close();
  }
}

final bloc = PostBloc();
