import 'package:dgon/Posts/PostCard.dart';
import 'package:flutter/material.dart';

class View_Post extends StatefulWidget {
  final snap;
  const View_Post({Key? key, this.snap}) : super(key: key);

  @override
  State<View_Post> createState() => _View_PostState();
}

class _View_PostState extends State<View_Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.snap['Username']),
        backgroundColor: Colors.green,
      ),
      body: PostCard(
        snap: widget.snap,
      ),
    );
  }
}
