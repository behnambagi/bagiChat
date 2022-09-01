import 'package:bagi_chat/features/chat/presentation/pages/chat_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../state.dart';

class PeopleScreen extends StatelessWidget {
  PeopleScreen({Key? key}) : super(key: key);
  final currentUser = FirebaseAuth.instance.currentUser?.uid;

  void callChatDetailScreen(BuildContext context, String name, String uid) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChatDetailScreen(
              friendName: name, friendUid: uid,)));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text("People"),
        ),
        // SliverToBoxAdapter(
        //   key: UniqueKey(),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 15),
        //     child: CupertinoSearchTextField(
        //       onChanged: (value) => userState.setSearchTerm(value),
        //       onSubmitted: (value) => userState.setSearchTerm(value),
        //     ),
        //   ),
        // ),
        SliverFillRemaining(
          child: Observer(
            builder: (context) {
              return ListView.builder(
                itemCount: userState.users.length,
                itemBuilder: (context, index){
                  var data = userState.users[index];
                  if(data.uid==currentUser) return Container();
                  var pic = data.picture;
                return  CupertinoListTile(
                    leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: pic!=null?NetworkImage(pic):
                    null, child: pic!=null?null:Text(data.name[0]),
                    ),
                    onTap: () => callChatDetailScreen(
                    context, data.name, data.uid),
                    title: Text(data.name),
                    subtitle: Text(data.status),
                    );
                }

              );
            }
          ),
        )
      ],
    );
  }
}

// SliverList(
// delegate: SliverChildListDelegate(
// userState.people.map((dynamic data) {
// var pic = data['pictures'];
// return
// },
// ).toList(),
// ),
// ),