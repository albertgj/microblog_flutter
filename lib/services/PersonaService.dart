import 'dart:convert';

import 'package:microblog/model/Persone.dart';
import 'package:http/http.dart' as http;
import 'package:microblog/services/API.dart';

class PersonaService {
  static const url = 'http://localhost:8080/api/v2/';

  Future<List<String>> findAll() async {
    return null;
  }

  Future<API<String>> savePersona(Persona p) async {
    return http
        .post(url + 'persone/',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: json.encode(p))
        .then(
      (data) {
        return API<String>(data: data.body);
      },
    );
  }
}
