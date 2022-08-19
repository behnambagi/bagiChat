import 'package:bagi_chat/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../main.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({Key? key}) : super(key: key);

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final _text = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _text.text = currentUser?.displayName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Observer(
                  builder: (BuildContext context) => CircleAvatar(
                    radius: 60,
                    child: userState.avatarUser != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.memory(
                        userState.avatarUser!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill),
                    )
                        : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800]),
                    ),
                  ),
                ),
              ),
              onPressed: () => userState.fromCamera()),
          const Text("Enter your name"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 55),
            child: CupertinoTextField(
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25),
              maxLength: 15,
              controller: _text,
              keyboardType: TextInputType.name,
              autofillHints: const <String>[AutofillHints.name],
            ),
          ),
          CupertinoButton.filled(
              child: const Text("Continue"),
              onPressed: () {
                FirebaseAuth.instance.currentUser
                    ?.updateDisplayName(_text.text);
                userState.createOrUpdateUserInFirestore(_text.text);
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const HomePage()));
              })
        ],
      ),
    );
  }
}