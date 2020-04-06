import 'package:flutter/material.dart';
import 'package:microblog/blocs/PostBloc.dart';
import 'package:microblog/model/Post.dart';
import 'package:microblog/view/PostDetail.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllPosts();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MicroBlog"),
      ),
      body: StreamBuilder(
        stream: bloc.allPosts,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
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

  Widget buildList(AsyncSnapshot<List<Post>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(64, 75, 96, .9),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                  border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.message, color: Colors.white),
                ),
              ),
              title: Text(
                snapshot.data[index].titolo,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.person, color: Colors.yellowAccent),
                  Text(
                    " ${snapshot.data[index].persona.username}",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetail(
                        id: snapshot.data[index].id,
                        data: snapshot.data[index].data,
                        titolo: snapshot.data[index].titolo,
                        persona: snapshot.data[index].persona,
                        text: snapshot.data[index].text,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
