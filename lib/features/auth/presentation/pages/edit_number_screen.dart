import 'package:bagi_chat/features/auth/presentation/pages/select_country_screen.dart';
import 'package:bagi_chat/features/auth/presentation/pages/verify_number_screen.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/images/images.dart';

class EditNumberScreen extends StatefulWidget {
  const EditNumberScreen({Key? key}) : super(key: key);

  @override
  State<EditNumberScreen> createState() => _EditNumberScreenState();
}

class _EditNumberScreenState extends State<EditNumberScreen> {
  final _enterPhoneNumber = TextEditingController();
  Map<String, dynamic> data = {"name": "Portugal", "code": "+98"};
  Map<String, dynamic>? dataResult;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Edit Number"),
        previousPageTitle: "Back",
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      color: CupertinoColors.white),
                  child: const ShowImage(
                    Images.whatsapp,
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.all(2),
                  )),
              Text("Verification • one step",
                  style: TextStyle(
                      color: const Color(0xFF08C187).withOpacity(0.7), fontSize: 25))
            ],
          ),
          Text("Enter your phone number",
              style: TextStyle(
                  color: CupertinoColors.systemGrey.withOpacity(0.7),
                  fontSize: 30)),
          CupertinoListTile(
            onTap: () async {
              dataResult = await Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const SelectCountryScreen()));
              setState(() {
                if (dataResult != null) data = dataResult!;
              });
            },
            title:
            Text(data['name'], style: const TextStyle(color: Color(0xFF08C187))),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(data['code'],
                    style: const TextStyle(
                        fontSize: 25, color: CupertinoColors.secondaryLabel)),
                Expanded(
                  child: CupertinoTextField(
                    placeholder: "Enter your phone number",
                    controller: _enterPhoneNumber,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 25, color: CupertinoColors.secondaryLabel),
                  ),
                )
              ],
            ),
          ),
          const Text("You will receive an activation code in short time",
              style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 15)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: CupertinoButton.filled(
                child: const Text("Request code"),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => VerifyNumberScreen(
                            number: data['code']! + _enterPhoneNumber.text,
                          )));
                }),
          )
        ],
      ),
    );
  }
}