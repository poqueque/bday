import 'package:bday/ui/widgets/MarkdownText.dart';
import 'package:bday/ui/widgets/Space.dart';
import 'package:bday/ui/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class CreditsView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBody: true,
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Space(size: 36),
                MarkdownText(
                  "Icons made by [Freepik](https://www.flaticon.com/authors/freepik) from [www.flaticon.com](https://www.flaticon.com/)",
                ),
                Space(),
                MarkdownText(
                  "Navigation side menu from *Damodar Lohani* and his amazing app [Flutter UI Challenges](https://play.google.com/store/apps/details?id=com.popupbits.flutteruichallenges)"
                ),
                Space(),
              ],
            ),
          ),
          DrawerMenu(scaffoldKey),
        ],
      ),
    );
  }
}
