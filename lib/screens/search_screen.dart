import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:instagram/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final textController = TextEditingController();

  bool isshowusers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Search for User'),
            onFieldSubmitted: (value) {
              setState(() {
                isshowusers = true;
              });
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .where('username', isGreaterThanOrEqualTo: textController.text)
              .get(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return isshowusers
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    uid: snapshot.data!.docs[index]['uid'],
                                  )));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data!.docs[index]['photourl']),
                          ),
                          title: Text(snapshot.data!.docs[index]['username']),
                        ),
                      );
                    })
                : FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection('posts').get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return MasonryGridView.count(
                        itemCount: snapshot.data!.docs.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                        itemBuilder: (context, index) {
                          return Image.network(
                              snapshot.data!.docs[index]['posturl']);
                        },
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
