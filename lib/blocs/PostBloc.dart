import 'package:microblog/model/Post.dart';
import 'package:microblog/resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc {
  final _repository = Repository();
  final _postFetcher = PublishSubject<List<Post>>();

  Stream<List<Post>> get allPosts => _postFetcher.stream;

  fetchAllPosts() async {
    List<Post> post = await _repository.fetchAllPosts();
    _postFetcher.sink.add(post);
  }
  dispose() {
    _postFetcher.close();
  }
}

 final bloc = PostBloc();