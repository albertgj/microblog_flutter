import 'package:get_it/get_it.dart';
import '../model/Comments.dart';
import '../service/Api.dart';
import 'BaseModel.dart';
import 'ViewState.dart';


class CommentModel extends BaseModel {
  Api _api = GetIt.I.get<Api>();

  List<Comment> comments;

  Future getComments(int id) async {
    setState(ViewState.Busy);
    comments = await _api.findCommentsOfPost(id);
    setState(ViewState.Idle);
  }
}
