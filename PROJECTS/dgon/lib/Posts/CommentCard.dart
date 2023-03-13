import 'dart:ui';

import 'package:dgon/Database_Model/User_Database.dart';
import 'package:dgon/Interests/Domain_Auth.dart';
import 'package:dgon/Profile/Profile_Details.dart';
import 'package:dgon/Providers/User_Provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final UserDatabase user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          widget.snap['ProfileImage'] == ""
              ? InkWell(
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/profile_icon.png"),
                    radius: 18,
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Profile_Details(uid: widget.snap['uid']))),
                )
              : InkWell(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.snap['ProfileImage']),
                    radius: 18,
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Profile_Details(uid: widget.snap['uid']))),
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: [
                            TextSpan(
                              text: "${widget.snap['Username']} ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.snap['Comment'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(widget.snap['DatePublished'].toDate()),
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ]),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                onPressed: () async {
                  await Domain_Auth.LikeComment(
                      widget.snap['PostID'],
                      widget.snap['CommentID'],
                      user.uid!,
                      widget.snap['Likes']);
                },
                icon: widget.snap['Likes'].contains(user.uid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                      ),
              )),
        ],
      ),
    );
  }
}
