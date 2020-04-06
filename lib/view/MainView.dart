import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/model/Persone.dart';
import 'package:microblog/model/Post.dart';
import 'package:microblog/services/API.dart';
import 'package:microblog/services/PostService.dart';
import 'package:microblog/view/PostPage.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  PostService get postService => GetIt.I<PostService>();
  API<List<Post>> _apiResponse;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  //VARIABILI
  final data = '2020-03-28 22:17:00';
  String text = '';
  String titolo = '';
  Persona persona = Persona(id: 4, username: 'tiziano');

  _fetchPosts() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await postService.findAllPosts();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    animationController = AnimationController(vsync: this);
    _textController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MicroBlog"),
        actions: <Widget>[
          IconButton(
            tooltip: "Aggiungi username",
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.yellowAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Compila il campo';
                            }
                            text = value;
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Compila il campo';
                            }
                            titolo = value;
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Color.fromRGBO(64, 75, 96, .9),
                          child: Text("INVIA"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                            }
                            Post p = new Post(
                                data: data,
                                persona: persona,
                                text: text,
                                titolo: titolo);
                            postService.savePost(p);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_apiResponse.error != null) {
            return Center(
              child: Text(_apiResponse.errorMessage),
            );
          }
          return ListView.builder(
            itemCount: _apiResponse.data.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 8.0,
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
                          right:
                              new BorderSide(width: 1.0, color: Colors.white24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.message, color: Colors.white),
                      ),
                    ),
                    title: Text(
                      _apiResponse.data[index].titolo,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.person, color: Colors.yellowAccent),
                        Text(
                          " ${_apiResponse.data[index].persona.username}",
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
                            builder: (context) => PostPage(
                              id: _apiResponse.data[index].id,
                              data: _apiResponse.data[index].data,
                              titolo: _apiResponse.data[index].titolo,
                              persona: _apiResponse.data[index].persona,
                              text: _apiResponse.data[index].text,
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
        },
      ),
    );
  }
}
