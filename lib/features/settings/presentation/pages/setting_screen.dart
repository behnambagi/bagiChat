import 'package:bagi_chat/features/settings/presentation/widgets/ios_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;

import '../../../../state.dart';
import '../widgets/ios_list_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(height: 40);
    var profile = userState.currentUser;
    if(profile==null) return const Center(child: CupertinoActivityIndicator(),);
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text("settings"),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              space,
              IosContainer(
                child: IosListTile(
                  leading: profile.circleAvatar(29),
                  title: Text(profile.name,
                      style: const TextStyle(fontSize: 22)),
                  subTitle: Text("Busy Doing Nothing...",
                      style: TextStyle(
                          fontSize: 17,
                          color: CupertinoColors.black.withOpacity(0.7))),
                ),
              ),
              space,
              const IosSortListTile(children: [
                IosListTile(
                    leading: IosIcon(
                        icon: CupertinoIcons.bookmark_fill,
                        color: mat.Colors.amber),
                    title: Text("Saved messages")),
                IosListTile(
                    leading: IosIcon(
                        icon: mat.Icons.devices,
                        color: mat.Colors.deepPurpleAccent),
                    title: Text("Devices Connected"))
              ]),
              space,
              const IosSortListTile(children: [
                IosListTile(
                    leading: IosIcon(
                        icon: CupertinoIcons.person_alt,
                        color: CupertinoColors.link),
                    title: Text("Account")),
                IosListTile(
                    leading: IosIcon(
                        icon: CupertinoIcons.chat_bubble_text_fill,
                        color: mat.Colors.deepOrangeAccent),
                    title: Text("Chat Setting")),
                IosListTile(
                    leading: IosIcon(
                        icon: CupertinoIcons.app_badge,
                        color: CupertinoColors.systemTeal),
                    title: Text("Notifications")),
                IosListTile(
                    leading: IosIcon(
                        icon: mat.Icons.language,
                        color: mat.Colors.green),
                    title: Text("Language")),
              ]),
              space,
              const IosSortListTile(children: [
                IosListTile(
                    leading: IosIcon(
                        icon: CupertinoIcons.chat_bubble_2_fill,
                        color: CupertinoColors.systemOrange),
                    title: Text("Ask a Question")),
                IosListTile(
                    leading: IosIcon(
                        icon: CupertinoIcons.at_badge_minus,
                        color: mat.Colors.lime),
                    title: Text("About AppLance")),
                IosListTile(
                    leading: IosIcon(
                        icon: CupertinoIcons.checkmark_shield,
                        color: CupertinoColors.systemTeal),
                    title: Text("Privacy Policy")),
              ]),
              space


            ]),
          )
        ],
      ),
    );
  }
}

