import 'package:bagi_chat/core/images/images.dart';
import 'package:bagi_chat/features/auth/presentation/pages/edit_number_screen.dart';
import 'package:flutter/cupertino.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = CupertinoColors.white.withOpacity(0.8);
    return CupertinoPageScaffold(
      child: BackdropBlur(
        image: Images.bg,
        children: [
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                  color: color),
              child: const ShowMedia(
                Images.whatsapp,
                width: 150,
                height: 150,
                padding: EdgeInsets.all(2),
              )),
          Text("Hello", style: TextStyle(color: color, fontSize: 60)),
          Text(
            "WhatsApp in a cross-platform \n mobile"
            " messaging with friends \n all over the world",
            textAlign: TextAlign.center,
            style: TextStyle(color: color, fontSize: 20),
          ),
          CupertinoButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: CupertinoColors.white),
              ),
              child: Text(
                "Terms and conditions",
                style: TextStyle(color: color),
              ),
            ),
          ),
          CupertinoButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.right_chevron, color: color),
                  Text("Let's Start", style: TextStyle(color: color, fontSize: 20))
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const EditNumberScreen()));
              })
        ],
      ),
    );
  }
}
