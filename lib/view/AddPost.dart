import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:microblog/model/Post.dart';
import 'package:microblog/model/User.dart';
import 'package:microblog/service/Api.dart';

class AddPost extends StatefulWidget {
  final String token;

  AddPost({this.token});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titolo;
  TextEditingController text;
  Api _api = GetIt.I<Api>();

  @override
  void initState() {
    titolo = TextEditingController();
    text = TextEditingController();
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
        title: Text("Add a post"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                key: UniqueKey(),
                controller: titolo,
                onTap: () {},
              ),
              TextField(
                controller: text,
                key: UniqueKey(),
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Material(
                  child: MaterialButton(
                    child: Text(
                      "AGGIUNGI",
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      User u = User(
                        id: Jwt.parseJwt(widget.token)['user_id'],
                        username: Jwt.parseJwt(widget.token)['sub'],
                      );

                      Post post = Post(
                        user: u,
                        data: "2020-07-11 15:00:00",
                        text: text.text,
                        titolo: titolo.text,
                      );

                      _api.savePost(post, widget.token);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
