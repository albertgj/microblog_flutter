import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/model/Comments.dart';
import 'package:microblog/model/User.dart';
import 'package:microblog/service/Api.dart';
import '../model/Comments.dart';

class CommentView extends StatefulWidget {
  final int id;
  final String titolo;
  final String data;
  final String text;
  final User user;

  CommentView({this.id, this.titolo, this.data, this.text, this.user});

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  Future<List<Comment>> commentList;
  Api _api = GetIt.I.get<Api>();

  @override
  void initState() {
    commentList = _api.findCommentsOfPost(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
      ),
      body: FutureBuilder<List<Comment>>(
        future: commentList,
        builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  color: Colors.blue,
                  child: ListTile(
                    title: Text(widget.text ?? ''),
                    subtitle: Text(widget.user.username),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {},
                        title: Text(snapshot.data[index].testo),
                      );
                    },
                  ),
                )
              ],
            );
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
}
