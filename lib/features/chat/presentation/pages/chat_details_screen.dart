import 'package:bagi_chat/core/utils/utils.dart';
import 'package:bagi_chat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen(
      {Key? key, required this.friendUid, required this.friendName})
      : super(key: key);
  final String friendUid;
  final String friendName;

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
        .where('users', isEqualTo: {widget.friendUid: null, currentUserId: null})
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
            'names': {currentUserId: FirebaseAuth.instance.currentUser?.displayName,
              widget.friendUid: widget.friendName}
          }).then((value) => {chatDocId = value});
        }
      },
    )
        .catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return  CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            child: CupertinoIcons.phone.icon),
        previousPageTitle: "back",
        middle: Text(widget.friendName),
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: chats.doc(chatDocId)
              .collection("messages")
              .orderBy("createdOn", descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      child: ListView.separated(reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ChatBubble(
                            clipper: ChatBubbleClipper6(
                              nipSize: 0,
                              radius: 25,
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(data['msg'],
                                          style: TextStyle(
                                              color: isSender(
                                                  data['uid'].toString())
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
                                            ? dateToHour(DateTime.now())
                                            : dateToHour(data['createdOn'].toDate()),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: isSender(
                                                data['uid'].toString())
                                                ? Colors.white
                                                : Colors.black),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        },
                        separatorBuilder: (BuildContext context, int index)=>
                        const SizedBox(height: 10,),
                        itemCount: snapshot.data?.docs.length??0,)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: CupertinoTextField(
                            onSubmitted: (v)=>sendMessage(v),
                        controller: _textController)),
                      CupertinoButton(
                          onPressed: () => sendMessage(_textController.text),
                          child: Icons.send_sharp.icon)
                    ],
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

  String intToDigits(int value){
    if(value<=9) return "0$value";
    return "$value";
  }

  String dateToHour (DateTime dateTime){
    var time = dateTime.toLocal();
    return "${intToDigits(time.hour)}"
        ":${intToDigits(time.minute)}";
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
