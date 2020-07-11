import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:microblog/model/Post.dart';
import 'package:microblog/service/Api.dart';
import 'package:microblog/service/AuthenticationService.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Api _api = GetIt.I.get<Api>();
  Future<List<Post>> postList;
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future<String> token;

  @override
  void initState() {
    postList = _api.findAllPosts();
    token = AuthenticationService().getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MicroBlog"),
      ),
      drawer: drawer(),
      body: FutureBuilder(
        future: postList,
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
      floatingActionButton: token == null
          ? null
          : FutureBuilder(
              future: token,
              builder: (context, snapshot) {
                return FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'addPost',
                      arguments: '${snapshot.data}',
                    );
                  },
                );
              },
            ),
    );
  }

  Widget drawer() {
    return FutureBuilder(
      future: token,
      builder: (context, snapshot) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: snapshot.data == null
                    ? Text("")
                    : Text('Hello ${Jwt.parseJwt(snapshot.data)['sub']}'),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              snapshot.data == null
                  ? ListTile(
                      title: Text("Login"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'login');
                      },
                    )
                  : ListTile(
                      title: Text("Logout"),
                      trailing: Icon(Icons.exit_to_app),
                      onTap: () {
                        storage.delete(key: "token");
                        setState(() {
                          token = null;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
              ListTile(
                title: Text("Home"),
                onTap: () {
                  print("U clicked me");
                },
              ),
              ListTile(
                title: Text("Change theme"),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        );
      },
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
              color: Colors.blue,
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
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.person, color: Colors.yellowAccent),
                  Text(
                    " ${snapshot.data[index].user.username}",
                    style: snapshot.data[index].user.username == 'aaa'
                        ? TextStyle(color: Colors.yellowAccent)
                        : TextStyle(color: Colors.white),
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
                  Post p = Post(
                      id: snapshot.data[index].id,
                      data: snapshot.data[index].data,
                      titolo: snapshot.data[index].titolo,
                      user: snapshot.data[index].user,
                      text: snapshot.data[index].text);
                  Navigator.pushNamed(context, 'post', arguments: p);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
