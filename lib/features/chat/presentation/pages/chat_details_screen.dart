import 'package:bagi_chat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

import '../../../../core/common/data.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen(
      {Key? key, required this.friendUid, required this.friendName,this.image})
      : super(key: key);
  final String friendUid;
  final String friendName;
  final String? image;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _textController = TextEditingController();
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  CollectionReference chats = FirebaseFirestore.instance.collection("chats");

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    await chats
        .where('users',
            isEqualTo: {widget.friendUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });
            } else {
              await chats.add({
                'users': {currentUserId: null, widget.friendUid: null},
                'names': {
                  currentUserId: FirebaseAuth.instance.currentUser?.displayName,
                  widget.friendUid: widget.friendName
                }
              }).then((value) => {chatDocId = value});
            }
          },
        )
        .catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            child: CupertinoIcons.phone.icon),
        previousPageTitle: "back",
        middle: Text(widget.friendName),
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: chats
              .doc(chatDocId)
              .collection("messages")
              .orderBy("createdOn", descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("Loading"),
              );
            }

            if (snapshot.hasData) {
              return SafeArea(
                  child: Column(
                children: [
                  Expanded(
                      child: Container(
                        color: Colors.white,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(bottom: 20),
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data?.docs[index].data()
                            as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ChatBubble(
                            clipper: ChatBubbleClipper6(
                              nipSize: 0,
                              radius: 15,
                              type: isSender(data['uid'].toString())
                                  ? BubbleType.sendBubble
                                  : BubbleType.receiverBubble,
                            ),
                            alignment: getAlignment(data['uid'].toString()),
                            margin: const EdgeInsets.only(top: 20),
                            backGroundColor: isSender(data['uid'].toString())
                                ? const Color(0xFF08C187)
                                : const Color(0xffE7E7ED),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(data['msg'],
                                          style: TextStyle(
                                              color:
                                                  isSender(data['uid'].toString())
                                                      ? Colors.white
                                                      : Colors.black),
                                          maxLines: 100,
                                          overflow: TextOverflow.ellipsis)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        data['createdOn'] == null
                                            ? DataTime.dateToHour(DateTime.now())
                                            : DataTime.dateToHour(
                                                data['createdOn'].toDate()),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                isSender(data['uid'].toString())
                                                    ? Colors.white
                                                    : Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 0,
                    ),
                    itemCount: snapshot.data?.docs.length ?? 0,
                  ),
                      )),
                  Container(
                    color: Colors.black12.withOpacity(0.03),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              child: CupertinoTextField(
                                  placeholder: "write something ..",
                                  maxLines: null,
                                  onSubmitted: (v) => sendMessage(v),
                                  controller: _textController),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () => _textController.text.isEmpty
                              ? null
                              : sendMessage(_textController.text),
                          child: const Icon(
                            Icons.send,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ));
            }
            return Container();
          }),
    );
  }

  void sendMessage(String msg) {
    if (msg == '') return;
    _textController.text = '';
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'friendName': widget.friendName,
      'msg': msg
    });
  }


  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }
}
