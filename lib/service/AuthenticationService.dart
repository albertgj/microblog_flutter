import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:microblog/model/User.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  FlutterSecureStorage storage = FlutterSecureStorage();
  static const url = 'http://192.168.1.149:8080/api/v2/';
  StreamController<User> userController = StreamController<User>();

  Future<bool> login(String username, String password) async {
    User user = User(username: username, password: password);
    var toJson = json.encode(user.toJson());

    final response = await http.post(url + 'signin', body: toJson, headers: {
      "content-type": "application/json",
      "accept": "application/json",
    });
    
    var token;

    if (response.statusCode == 200) {
      token = json.decode(response.body)['body']['token'];
      userController.add(user);
      //storage.write(key: "token", value: token);
      return true;
    } else {
      return false;
    }
  }
}
