import 'package:flutter/material.dart';
import 'package:microblog/model/Comments.dart';
import 'package:microblog/model/User.dart';
import 'package:microblog/viewmodel/CommentModel.dart';
import '../model/Comments.dart';
import '../viewmodel/ViewState.dart';
import 'BaseView.dart';

class CommentView extends StatelessWidget {
  final int id;
  final String titolo;
  final String data;
  final String text;
  final User user;

  CommentView({this.id, this.titolo, this.data, this.text, this.user});

  @override
  Widget build(BuildContext context) {
    return BaseView<CommentModel>(
      onModelReady: (model) => model.getComments(this.id),
      builder: (context, model, child) => model.state == ViewState.Idle
          ? Scaffold(
              appBar: AppBar(
                title: Text("Post"),
              ),
              body: buildList(model.comments),
            )
          : CircularProgressIndicator(),
    );
  }

  Widget buildList(List<Comment> lista) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Text(lista[index].testo),
          ],
        );
      },
    );
  }
}
