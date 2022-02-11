import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset('assets/images/ic_instagram.svg',
            color: primaryColor, height: 32),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snspshot) {
          if (snspshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snspshot.hasData) {
            return ListView.builder(
              itemCount: snspshot.data!.docs.length,
              itemBuilder: (context, index) => PostCard(
                snap: snspshot.data!.docs[index].data(),
              ),
            );
          }

          return Text('No data');

          // return ListView.builder(
          //   itemCount: snspshot.data!.docs.length,
          //   itemBuilder: (context, index) => PostCard(

          //     snap: snspshot.data!.docs[index].data(),
          //   ),
          // );
        },
      ),
    );
  }
}
