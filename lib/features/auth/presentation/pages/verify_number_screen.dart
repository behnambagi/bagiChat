import 'package:bagi_chat/core/utils/utils.dart';
import 'package:bagi_chat/features/auth/presentation/pages/user_name_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum Status { waiting, error }

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen({Key? key, required this.number}) : super(key: key);
  final String number;

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  late String phoneNumber;
  var _status = Status.waiting;
  late String _verificationId;
  final _textEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.number;
    _verifyPhoneNumber();
  }

  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 5),
      verificationCompleted: (AuthCredential auth) {
        logger.d('verified');
      },
      verificationFailed: (e) {
        logger.d("error code  :${e.code} error massage : ${e.message}");
      },
      codeSent: (String verId, forceCodeResend) {
        setState(() {});
        _verificationId = verId;
      },
      codeAutoRetrievalTimeout: (String verId) {
        _verificationId = verId;
      },
    );
  }

  Future _sendCodeToFirebase({String? code}) async {
    logger.d(_verificationId);
    var credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: code!);
    await _auth
        .signInWithCredential(credential)
        .then((value) {
          logger.d(value);
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => const UserNameScreen()));
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          setState(() {
            logger.d("message");
            _textEditingController.text = "";
            _status = Status.error;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Verify Number"),
        previousPageTitle: "Edit Number",
      ),
      child: _status != Status.error
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text("OTP Verification",
                      style: TextStyle(
                          color: const Color(0xFF08C187).withOpacity(0.7),
                          fontSize: 30)),
                ),
                const Text("Enter OTP sent to",
                    style: TextStyle(
                        color: CupertinoColors.secondaryLabel, fontSize: 20)),
                Text(phoneNumber),
                CupertinoTextField(
                    onChanged: (value) async {
                      if (value.length == 6) {
                        _sendCodeToFirebase(code: value);
                      }
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(letterSpacing: 30, fontSize: 30),
                    maxLength: 6,
                    controller: _textEditingController,
                    keyboardType: TextInputType.number),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive the OTP?"),
                    CupertinoButton(
                        child: const Text("RESEND OTP"),
                        onPressed: () async {
                          setState(() {
                            _status = Status.waiting;
                          });
                          _verifyPhoneNumber();
                        })
                  ],
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text("OTP Verification",
                      style: TextStyle(
                          color: const Color(0xFF08C187).withOpacity(0.7),
                          fontSize: 30)),
                ),
                const Text("The code used is invalid!"),
                CupertinoButton(
                    child: const Text("Edit Number"),
                    onPressed: () => Navigator.pop(context)),
                CupertinoButton(
                    child: const Text("Resend Code"),
                    onPressed: () async {
                      setState(() {
                        _status = Status.waiting;
                      });
                      _verifyPhoneNumber();
                    }),
              ],
            ),
    );
  }
}
