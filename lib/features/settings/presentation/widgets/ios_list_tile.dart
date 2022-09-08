import 'package:flutter/cupertino.dart';

import 'ios_container.dart';

class IosListTile extends StatelessWidget {
  final Widget title;
  final double width;
  final double? height;
  final Widget? subTitle;
  final Widget leading;
  final bool noPadding;
  final void Function()? onTap;

  const IosListTile(
      {Key? key,
      required this.title,
      this.width = double.infinity,
      this.height,
      this.subTitle,
      required this.leading, this.onTap, this.noPadding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: width,
          height: height,
          child: Row(mainAxisSize: MainAxisSize.max, children: [
           if(!noPadding) const SizedBox(width: 16),
            leading,
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                if (subTitle != null) ...[const SizedBox(height: 4), subTitle!]
              ],
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.right_chevron,
              color: CupertinoColors.inactiveGray,
              size: 20,
            ),
            const SizedBox(width: 16),
          ]),
        ),
      ),
    );
  }
}

class IosIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IosIcon({Key? key, required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(7), color: color),
      child: Icon(
        icon,
        color: CupertinoColors.white,
        size: 16,
      ),
    );
  }
}

class IosSortListTile extends StatelessWidget {
  final List<Widget> children;

  const IosSortListTile({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IosContainer(
        height: null,
        child: Column(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1)
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 65),
                  width: double.infinity,
                  color: CupertinoColors.black.withOpacity(0.2),
                  height: .6,
                )
            ],
          ],
        ));
  }
}
