import 'package:bagi_chat/core/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';


part 'chat_state.g.dart';


class ChatState = _ChatState  with _$ChatState;

abstract class _ChatState with Store{

  String? currentUser = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');

  @observable
  Map<String, dynamic> messages = ObservableMap();

  @action
  void refreshChatsForCurrentUser(){
    var chatDocs= [];
     chats.where('users.$currentUser', isNull: true).snapshots().listen((event) {
      chatDocs = event.docs.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
         Map<String, dynamic> names = data['names'];
         names.remove(currentUser);
         if(names.values.isNotEmpty) {
           return {'docId': e.id, 'name':
           names.values.first, 'friendId': names.keys.first};
         }
      }).toList();
      chatDocs.removeWhere((element) => element==null);
      for (var doc in chatDocs) {
       FirebaseFirestore.instance.collection('chats/${doc['docId']}/messages')
           .orderBy('createdOn',descending: true)
           .limit(1)
           .snapshots()
           .listen((event) {
          if(event.docs.isNotEmpty){
            messages[doc['name']] = {
              'msg':event.docs.first['msg'],
              'time':event.docs.first['createdOn'],
              'friendName':doc['name'],
              'friendUid':doc['friendId']
            };
          }
       });

      }

     });
  }



}