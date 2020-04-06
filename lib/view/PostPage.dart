import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/model/Comments.dart';
import 'package:microblog/model/Persone.dart';
import 'package:microblog/services/API.dart';
import 'package:microblog/services/PostService.dart';

class PostPage extends StatefulWidget {
  final int id;
  final String titolo;
  final String data;
  final String text;
  final Persona persona;

  PostPage({this.id, this.titolo, this.data, this.text, this.persona});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostService get postService => GetIt.I<PostService>();
  API<List<Comment>> _apiResponse;
  bool _isLoading = false;
  //final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  _fetchComments() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await postService.findCommentsOfPost(widget.id);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchComments();
    _textController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commenti"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.comment),
        backgroundColor: Colors.yellowAccent,
        onPressed: () {},
      ),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: _apiResponse.data.length,
            itemBuilder: (context, index) {
              return Card(
                child: Text(_apiResponse.data[index].testo),
              );
            },
          );
        },
      ),
    );
  }
}
