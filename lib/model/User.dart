class User {
  int id;
  String username;
  String password;
  List roles;

  User({this.id, this.username, this.password, this.roles});

  factory User.fromJson(Map json) {
    return User(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        roles: json['roles']);
  }

  Map<String, dynamic> registerUser() {
    return {
      'username': username,
      'password': password,
      'role': ['user']
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }
}
