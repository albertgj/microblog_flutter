import 'package:microblog/model/Persone.dart';
import 'package:microblog/model/Post.dart';

class Comment {
  int id;
  String date;
  String testo;
  Post post;
  Persona persona;

  Comment({this.id, this.date, this.testo, this.post, this.persona});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      date: json['data'],
      testo: json['testo'],
      post: Post.fromJson(
        json['post'],
      ),
      persona: Persona.fromJson(
        json['persona'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'testo': testo,
      'persona': persona
    };
  }
}
