import 'dart:typed_data';

import 'package:bagi_chat/core/common/picture_selector.dart';
import 'package:bagi_chat/core/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';

part 'user_state.g.dart';

class UserState = _UserState with _$UserState;

abstract class _UserState with Store {

  String? currentUser = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  @observable
  Map<String, dynamic> users = ObservableMap();

  String? _avatarUrl;

  var selector = PictureSelector();

  @observable
  Uint8List? avatarUser;


  @observable
  String searchUser = '';

  @computed
  List<dynamic> get people {
    logger.d("message");
    return users.entries
        .where((user) => user.key != currentUser)
        .where((user) => user.value['name']
        .toLowerCase()
        .startsWith(searchUser.toLowerCase()))
        .map((e) => e.value)
        .toList();
  }

  @action
  setSearchTerm(String value) {
    searchUser = value;
  }

  @action
  void initUsersListener() {
    usersCollection.snapshots().listen((event) {
      for (var doc in event.docs) {
        var data = doc.data() as Map<String, dynamic>;
        users[data['uid']] = {
          'name': data['name'],
          'phone': data['phone'],
          'status': data['status'],
          'picture': data['picture']
        };
      }
    });
  }

  void _uploadImage(){
    if(avatarUser==null) return;
    final storageRef = FirebaseStorage.instance.ref();
    var avatarUserRef = storageRef.child('$currentUser/photos/profile.jpg');
    avatarUserRef.putData(avatarUser!).then((taskSnapShot){
      switch(taskSnapShot.state){
        case TaskState.paused:
          break;
        case TaskState.running:
          break;
        case TaskState.success:
          avatarUserRef.getDownloadURL().then((value) => _avatarUrl = value);
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          logger.d("error");
          break;
      }

    });
  }

  void fromCamera()async=> {
    avatarUser = await selector.fromCamera(),
    _uploadImage()
  };
  void fromGallery()async=> {
    avatarUser = await selector.fromGallery(),
    _uploadImage()
  };


  void createOrUpdateUserInFirestore(String userName) {
    FirebaseAuth.instance.currentUser?.updateDisplayName(userName);
    String? docId;
    usersCollection
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .limit(1)
          .get()
          .then(
            (QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isEmpty) {
            usersCollection.add({
              'name': userName,
              'phone': FirebaseAuth.instance.currentUser?.phoneNumber,
              'status': 'Available',
              'uid': FirebaseAuth.instance.currentUser?.uid,
              'picture': _avatarUrl
            });
          } else {
            docId = querySnapshot.docs.first.id;
          }
          //update user info in firestore use case
          if (docId != null) {
            usersCollection.doc(docId).update({
              'name': userName,
              'phone': FirebaseAuth.instance.currentUser?.phoneNumber,
              'status': 'Available',
              'uid': FirebaseAuth.instance.currentUser?.uid,
              'picture': _avatarUrl
            });
          }
        },
      ).catchError((error) {});
  }
}

