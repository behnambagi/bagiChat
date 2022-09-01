import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/use_cases/people_use_cases.dart';
import '../models/person_model.dart';

abstract class PersonRemoteDataSource {
  Stream<List<PersonModel>> getConcretePeople({String? searchParams});

  Stream<PersonModel> getConcretePerson(String uid);

  Future<bool> postConcreteEditProfile(EditProfParams params);

  Future<String> postConcreteUpdatePicture(Uint8List bytes);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final FirebaseFirestore client;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  PersonRemoteDataSourceImpl({required this.auth,
    required this.storage, required this.client});

  @override
  Stream<List<PersonModel>> getConcretePeople({String? searchParams}) {
    final subject = PublishSubject<List<PersonModel>>();
    client.collection('users').snapshots().listen((event) {
      var list = event.docs.map((e) => PersonModel.fromJson(e.data())).toList();
      subject.add(list);
    });
    return subject.stream;
  }

  @override
  Stream<PersonModel> getConcretePerson(String uid) {
    final subject = PublishSubject<PersonModel>();
    client
        .collection('users')
        .where("uid", isEqualTo: uid)
        .limit(1)
        .snapshots()
        .listen((event) {
      var item = event.docs.single.data();
      subject.add(PersonModel.fromJson(item));
    });
    return subject.stream;
  }

  @override
  Future<bool> postConcreteEditProfile(EditProfParams params) async {
    var currentUser = auth.currentUser;
    var userC = client.collection("users");
    var person = PersonModel(uid: currentUser?.uid??"",picture: params.picUrl,
        name: params.name, phone: currentUser?.phoneNumber??"", status: "Available");
    currentUser?.updateDisplayName(params.name);
    var res =
        await userC.where('uid', isEqualTo: currentUser?.uid).limit(1).get();
    if (res.docs.isEmpty) {
      await userC.add(person.toMap());
      return true;
    }
    var docId = res.docs.first.id;
    await userC.doc(docId).update(person.toMap());
    return true;
  }

  @override
  Future<String> postConcreteUpdatePicture(Uint8List bytes) async{
    var currentUser = auth.currentUser;
    final storageRef = storage.ref();
    var avatarUserRef = storageRef.child('$currentUser/photos/profile.jpg');
    var res = await avatarUserRef.putData(bytes);
    switch(res.state){
    case TaskState.success:
    return await avatarUserRef.getDownloadURL();
    case TaskState.error:
      default:{
        logger.d(res.toString());
        throw Error();
      }
    }

    }
}
