import 'package:flutter/material.dart';
import 'package:microblog/model/Post.dart';
import 'package:microblog/view/BaseView.dart';
import 'package:microblog/viewmodel/HomeModel.dart';
import 'package:microblog/viewmodel/ViewState.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) {
        model.getPosts();
      },
      builder: (ctx, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("MicroBlog"),
        ),
        drawer: drawer(context),
        body: model.state == ViewState.Idle
            ? buildList(model.posts)
            : Center(
                child: CircularProgressIndicator(),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'post');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget drawer(ctx) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("Hello"),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text("Login"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(ctx, 'login');
              //Navigator.pop(context);
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
  }

  Widget buildList(List<Post> lista) {
    return ListView.builder(
      itemCount: lista.length,
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
                lista[index].titolo,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.person, color: Colors.yellowAccent),
                  Text(
                    " ${lista[index].user.username}",
                    style: lista[index].user.username == 'aaa'
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
                      id: lista[index].id,
                      data: lista[index].data,
                      titolo: lista[index].titolo,
                      user: lista[index].user,
                      text: lista[index].text);
                  Navigator.pushNamed(context, 'post', arguments: p);
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentView(
                        id: lista[index].id,
                        data: lista[index].data,
                        titolo: lista[index].titolo,
                        user: lista[index].user,
                        text: lista[index].text,
                      ),
                    ),
                  );
                  */
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
