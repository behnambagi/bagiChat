import 'package:bagi_chat/features/chat/presentation/manager/chat_state.dart';
import 'package:bagi_chat/features/chat/presentation/pages/chat_details_screen.dart';
import 'package:bagi_chat/state.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/common/data.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  var chatState = ChatState();

  @override
  initState() {
    chatState.refreshChatsForCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      return CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text("Chats"),
            automaticallyImplyLeading: false,
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                  chatState.messages.values.toList().map((e) {
            var user = userState.users[e['uid']];
            var pic = user == null ? null : user['pictures'];
            return CupertinoListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: pic != null
                      ? NetworkImage(userState.users[e['uid']]['picture'])
                      : null,
                  child: pic != null ? null : Text(e['friendName'][0]),
                ),
                title: Text(e['friendName']),
                subtitle: Text(e['msg']),
                trailing: Text(DataTime.dateToHour(
                    e['time'].toDate())),
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ChatDetailScreen(
                              friendName: e['friendName'],
                              friendUid: e['friendUid'],
                          image: pic),
                            )));
          }).toList()))
        ],
      );
    });
  }

}
