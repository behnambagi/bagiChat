import 'package:bagi_chat/features/people/presentation/pages/people_screen.dart';
import 'package:bagi_chat/features/settings/presentation/pages/setting_screen.dart';
import 'package:bagi_chat/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'features/auth/presentation/pages/auth_gate.dart';
import 'features/chat/presentation/pages/chats_screen.dart';

const USE_EMULATORS = false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: GetPlatform.isAndroid?null:const FirebaseOptions(
        apiKey: "AIzaSyCDnvZ65bamLVsKm6bS4JuJUsBxWpvB6wU",
        authDomain: "bagichat-applance.firebaseapp.com",
        projectId: "bagichat-applance",
        storageBucket: "bagichat-applance.appspot.com",
        messagingSenderId: "402441537356",
        appId: "1:402441537356:web:05e715dda4742b519a31e9",
        measurementId: "G-V48L2Y1XRL")
  );
  if(USE_EMULATORS)await _connectToFirebase();
  runApp(const MyApp());
}


Future<void> _connectToFirebase()async{
  const localHost = 'localhost';
  FirebaseFirestore.instance.settings =const Settings(
    host: "$localHost:4444",
    sslEnabled: false,
    persistenceEnabled: false);
  await FirebaseAuth.instance.useEmulator("http://$localHost:7777");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'bagi chat',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xff08C187),
      ),
      home: AuthGate(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
@override
  initState(){
  chatState.refreshChatsForCurrentUser();
  userState.initUsersListener();
    super.initState();
  }
  final List list=[const ChatsScreen(),const Center(child: Text("data")),
    PeopleScreen(),const SettingScreen()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        resizeToAvoidBottomInset: true,
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(icon: CupertinoIcons.chat_bubble_fill.icon, label: "Chats"),
          BottomNavigationBarItem(icon: CupertinoIcons.phone.icon, label: "Calls"),
          BottomNavigationBarItem(icon: CupertinoIcons.person_alt_circle.icon, label: "Person"),
          BottomNavigationBarItem(icon: CupertinoIcons.settings_solid.icon, label: "Settings"),
        ]),
        tabBuilder: (BuildContext context, int index) {
          return list[index];
        },
      ),
    );
  }
}

extension IconConvert on IconData {
  Icon get icon => Icon(this);
}

