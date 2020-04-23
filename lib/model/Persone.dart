class Persona {
  int id;
  String username;
  String password;

  Persona({this.id, this.username, this.password});

  factory Persona.fromJson(Map json) {
    return Persona(
      id: json['id'],
      username: json['username'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password
    };
  }
}

