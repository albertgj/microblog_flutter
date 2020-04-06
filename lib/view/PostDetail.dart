import 'package:flutter/material.dart';
import 'package:microblog/model/Persone.dart';

class PostDetail extends StatefulWidget {
  final int id;
  final String titolo;
  final String data;
  final String text;
  final Persona persona;

  PostDetail({this.id, this.titolo, this.data, this.text, this.persona});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
      ),
      body: Container(
        child: Center(
          child: Text("${widget.data} ${widget.titolo} ${widget.text}"),
        ),
      ),
    );
  }
}
