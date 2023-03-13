import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgon/Database_Model/Post_Database.dart';
import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Providers/User_Provider.dart';
import 'package:dgon/Reusable_Widgets/Reusable.dart';
import 'package:dgon/Screens/Home.dart';
import 'package:dgon/Storage/Upload_Post.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPost extends StatefulWidget {
  final String GroupName;
  final Uint8List file;
  const AddPost({Key? key, required this.GroupName, required this.file})
      : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController description = TextEditingController();
  Uint8List? _file;
  String GroupName = "";
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    description.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GroupName = widget.GroupName;
    _file = widget.file;
  }

  void post(String uid, String Username, String ProfileImage) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await UploadPost.post1(description.text, uid, Username,
          ProfileImage, _file!, widget.GroupName);
      if (res == "Success") {
        setState(() {
          isLoading = false;
        });
        snackBar(context, "Posted Successfully");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()));
      } else {
        setState(() {
          isLoading = false;
        });
        snackBar(context, res);
      }
    } catch (e) {
      snackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserDatabase user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Post To",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () => post(user.uid!, user.Username!, user.PhotoUrl!),
              style: TextButton.styleFrom(),
              child: const Text(
                'Post',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ))
        ],
      ),
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 80,
        ),
        isLoading
            ? const LinearProgressIndicator()
            : const Padding(
                padding: EdgeInsets.only(top: 0),
              ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: user.PhotoUrl == null
                  ? const NetworkImage(
                      "https://img.freepik.com/free-icon/user_318-749758.jpg?w=2000")
                  : NetworkImage(user.PhotoUrl!),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                controller: description,
                decoration: const InputDecoration(
                    hintText: "Write a Caption", border: InputBorder.none),
                maxLines: 8,
              ),
            ),
            SizedBox(
              height: 35,
              width: 45,
              child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter))),
              ),
            ),
            const Divider(),
          ],
        )
      ]),
    );
  }
}
