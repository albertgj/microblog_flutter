import 'package:get_it/get_it.dart';
import 'package:microblog/service/AuthenticationService.dart';
import 'package:microblog/viewmodel/BaseModel.dart';
import 'package:microblog/viewmodel/ViewState.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      GetIt.I.get<AuthenticationService>();
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    setState(ViewState.Busy);

    var success = await _authenticationService.login(username, password);

    setState(ViewState.Idle);

    return success;
  }
}
