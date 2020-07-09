import 'package:microblog/model/User.dart';
import 'package:microblog/model/Post.dart';

class Comment {
  int id;
  String date;
  String testo;
  Post post;
  User user;

  Comment({this.id, this.date, this.testo, this.post, this.user});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      date: json['data'],
      testo: json['testo'],
      post: Post.fromJson(
        json['post'],
      ),
      user: User.fromJson(
        json['user'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'date': date, 'testo': testo, 'user': user};
  }
}
