import 'package:microblog/model/User.dart';

class Post {
  int id;
  String titolo;
  String data;
  String text;
  User user;

  Post({this.id, this.titolo, this.data, this.text, this.user});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      titolo: json['titolo'],
      data: json['data'],
      text: json['text'],
      user: User.fromJson(
        json['user'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titolo': titolo,
      'data': data,
      'text': text,
      'user': user.toJson()
    };
  }

  int get getId {
    return this.id;
  }

  String get getTitolo {
    return this.titolo;
  }

  String get getData {
    return this.data;
  }

  String get getText {
    return this.text;
  }

  User get getUser {
    return this.user;
  }

  set setId(int id) {
    this.id = id;
  }

  set setTitolo(String titolo) {
    this.titolo = titolo;
  }

  set setData(String data) {
    this.data = data;
  }

  set setText(String text) {
    this.text = text;
  }

  set setUser(User user) {
    this.user = user;
  }
}
