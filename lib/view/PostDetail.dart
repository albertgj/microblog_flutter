import 'package:flutter/material.dart';
import 'package:microblog/model/Comments.dart';
import 'package:microblog/model/User.dart';
import 'package:microblog/service/PostApiProvider.dart';

class PostDetail extends StatefulWidget {
  final int id;
  final String titolo;
  final String data;
  final String text;
  final User user;

  PostDetail({this.id, this.titolo, this.data, this.text, this.user});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Future<List<Comment>> listComments;

  @override
  void initState() {
    listComments = PostApiProvider().findAllCommentsOfPost(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
      ),
      body: FutureBuilder(
        future: listComments,
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
          children: <Widget>[Text("TEST")],
        );
      },
    );
  }
}
