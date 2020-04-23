import 'package:microblog/resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _repository = Repository();
  final _authenticate = PublishSubject<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get authenticateUser => _authenticate.stream;

  loginUser(String username, String password) async {
    Map<String, dynamic> jwt =
        await _repository.authenticate(username, password);
    _authenticate.sink.add(jwt);
  }

  dispose() {
    _authenticate.close();
  }
}

final loginBloc = LoginBloc();
