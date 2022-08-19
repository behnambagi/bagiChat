import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: [
        Center(child: CupertinoButton.filled(child: Text("data"),
            onPressed: (){


              FirebaseAuth.instance.signOut();

            }))
      ],
    ),);
  }
}
