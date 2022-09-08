import 'package:bagi_chat/core/config/themes/app_theme.dart';
import 'package:bagi_chat/features/auth/presentation/pages/user_name_screen.dart';
import 'package:bagi_chat/state.dart';
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
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.number;
    loginState.sendCode(phoneNumber);
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
          Center(child: Text("OTP Verification",
                style: AppTheme.titleStyle),
          ),
          const SizedBox(height: 20,),
          const Text("Enter OTP sent to", style: TextStyle(
                  color: CupertinoColors.secondaryLabel, fontSize: 20)),
          const SizedBox(height: 20,),

          Text(phoneNumber),
          const SizedBox(height: 20,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: CupertinoTextField(
                onChanged: (value) async {
                  if (value.length == 6) _verifyNumber(value, context);
                },
                textAlign: TextAlign.center,
                style: const TextStyle(letterSpacing: 30, fontSize: 30),
                maxLength: 6,
                controller: _textEditingController,
                keyboardType: TextInputType.number),
          ),
          const SizedBox(height: 10,),

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
                    loginState.verifyNumber(phoneNumber);
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
                    fontSize: 33)),
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
                loginState.verifyNumber(phoneNumber);
              }),
        ],
      ),
    );
  }

  _verifyNumber(String code, BuildContext context) async {
    var res = await loginState.verifyNumber(code);
    if (mounted && res) {
      return await Navigator.push(
          context, CupertinoPageRoute(builder: (context) => const UserNameScreen()));
    }
  }
}