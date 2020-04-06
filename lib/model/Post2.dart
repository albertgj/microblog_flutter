import 'package:microblog/model/Persone.dart';

class Post {
  int id;
  String titolo;
  String data;
  String text;
  Persona persona;

  Post({this.id, this.titolo, this.data, this.text, this.persona});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      titolo: json['titolo'],
      data: json['data'],
      text: json['text'],
      persona: Persona.fromJson(
        json['persona'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titolo': titolo,
      'data': data,
      'text': text,
      'persona': persona
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

  Persona get getPersona {
    return this.persona;
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

  set setPersona(Persona persona) {
    this.persona = persona;
  }
}
