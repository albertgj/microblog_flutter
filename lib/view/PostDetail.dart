import 'package:flutter/material.dart';
import 'package:microblog/blocs/PostBloc.dart';
import 'package:microblog/model/Comments.dart';
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
  void initState() {
    bloc.findAllCommentsOfPost(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    //bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
      ),
      body: StreamBuilder(
        stream: bloc.commentsOfPost,
        builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<Comment>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Text("TEST")
          ],
        );
      },
    );
  }
}
