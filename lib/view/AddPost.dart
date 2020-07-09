import 'package:flutter/material.dart';
import 'package:microblog/model/User.dart';
import 'package:microblog/model/Post.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titolo;
  TextEditingController data;
  TextEditingController text;

  @override
  void initState() {
    titolo = TextEditingController();
    data = TextEditingController();
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
        title: Text("Aggiungi post"),
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
                controller: data,
                key: UniqueKey(),
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
                      style: TextStyle(color: Colors.yellowAccent),
                    ),
                    color: Color.fromRGBO(64, 75, 96, .9),
                    onPressed: () {
                      User p = new User(id: 1, username: "aaa");
                      Post post = new Post(user: p, data: "", text: text.text, titolo: titolo.text);
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
