import 'package:flutter/material.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/resources/firestore_methods.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final dynamic snap;

  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  PostModel? postModel;
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(userModel.photourl!),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.snap['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        WidgetSpan(child: SizedBox(width: 5)),
                        TextSpan(text: widget.snap['text']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datepiblished'].toDate()),
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.favorite),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     FirestoreMethods().removecomment(
          //         postId: postModel!.postId!,
          //         commentId: widget.snap['commentId']);
          //   },
          //   child: Container(
          //     padding: const EdgeInsets.all(8),
          //     child: const Icon(Icons.delete),
          //   ),
          // )
        ],
      ),
    );
  }
}
