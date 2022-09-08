import 'package:bagi_chat/core/config/themes/app_theme.dart';
import 'package:bagi_chat/features/auth/presentation/pages/select_country_screen.dart';
import 'package:bagi_chat/features/auth/presentation/pages/verify_number_screen.dart';
import 'package:bagi_chat/features/settings/presentation/widgets/ios_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/images/images.dart';

class EditNumberScreen extends StatefulWidget {
  const EditNumberScreen({Key? key}) : super(key: key);

  @override
  State<EditNumberScreen> createState() => _EditNumberScreenState();
}

class _EditNumberScreenState extends State<EditNumberScreen> {
  final _enterPhoneNumber = TextEditingController();
  Map<String, dynamic> data = {"name": "Iran", "code": "+98"};
  Map<String, dynamic>? dataResult;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Edit Number"),
        previousPageTitle: "Back",
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Wrap(
              spacing: 5,
              runSpacing: 17,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30),
                            color: CupertinoColors.white),
                        child: const ShowMedia(
                          Images.whatsapp,
                          width: 80, height: 80)),
                    Text("Verification • one step",
                        style: AppTheme.titleStyle)
                  ],
                ),
                IosListTile(
                  noPadding: true,
                  onTap: () async {
                    dataResult = await Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => const SelectCountryScreen()));
                    setState(() {
                      if (dataResult != null) data = dataResult!;
                    });
                  },
                  leading: const Icon(Icons.language),
                  title:Text(data['name'], style: const TextStyle(color: Color(0xFF08C187))
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text("Enter your phone number",
                      style: AppTheme.inputTextStyle),
                ),
                Row(
                  children: [
                    Text(data['code'],
                        style: const TextStyle(
                            fontSize: 25, color: CupertinoColors.secondaryLabel)),
                    const SizedBox(width: 7),
                    Expanded(
                      child: CupertinoTextField(
                        placeholder: "Enter your phone number",
                        controller: _enterPhoneNumber,
                        padding: const EdgeInsets.all(15),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            fontSize: 15, color: CupertinoColors.secondaryLabel),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text("You will receive an activation code in short time",
                      style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 15)),
                ),
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
          ),
        ],
      ),
    );
  }
}