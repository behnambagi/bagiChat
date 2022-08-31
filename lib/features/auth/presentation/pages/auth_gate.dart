import 'package:bagi_chat/features/auth/presentation/pages/hello_screen.dart';
import 'package:bagi_chat/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
        builder:(BuildContext context, snapShot){
          if(snapShot.connectionState==ConnectionState.waiting){
            return const CupertinoPageScaffold(child:
            Center(child: Text("loading ..."),));
          }
          if(!snapShot.hasData){
          return const HelloScreen();
        }
        return const HomePage();


    });
  }
}
