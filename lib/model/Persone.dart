class Persona {
  int id;
  String username;

  Persona({this.id, this.username});

  factory Persona.fromJson(Map json) {
    return Persona(
      id: json['id'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }
}

