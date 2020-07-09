import 'package:get_it/get_it.dart';
import 'package:microblog/model/Post.dart';
import 'package:microblog/service/Api.dart';
import 'package:microblog/viewmodel/BaseModel.dart';
import 'package:microblog/viewmodel/ViewState.dart';

class HomeModel extends BaseModel {
  Api _api = GetIt.I.get<Api>();

  List<Post> posts;

  Future getPosts() async {
    setState(ViewState.Busy);
    posts = await _api.findAllPosts();
    setState(ViewState.Idle);
  }
}
