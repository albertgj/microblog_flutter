import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:microblog/model/Persone.dart';

class JwtApiProvider {
  static const url = 'http://192.168.1.223:8080/api/v2/';
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> authenticate(
      String username, String password) async {
    Persona p = Persona(username: username, password: password);
    final response = await http.post(
      url + 'authenticate',
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: json.encode(
        p.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      print(map["jwttoken"]);
      storage.write(key: "jwt", value: map["jwttoken"]);
      return json.decode(response.body);
    }
    print(response.body);
    return null;
  }
}
