import 'package:bday/ui/utils/app_icons.dart';
import 'package:bday/ui/widgets/Space.dart';
import 'package:bday/ui/widgets/animated_logo.dart';
import 'package:bday/ui/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:markup_text/markup_text.dart';
import 'package:package_info/package_info.dart';

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
                AnimatedLogo(),
                Space(),
                MarkupText(
                  "This app is made in (b)Flutter(/b) by (a http://eduardcarreras.net)Eduard Carreras(/a). You can hire him on (a https://www.toptal.com/resume/eduard-carreras#connect-exclusively-masterly-architects  )Toptal(/a) platform",
                ),
                Space(),
                MarkupText(
                  "Icons made by (a https://www.flaticon.com/authors/freepik)Freepik(/a) from (a https://www.flaticon.com/)www.flaticon.com(/a)",
                ),
                Space(),
                MarkupText(
                    "Navigation side menu from (b)Damodar Lohani(/b) and his amazing app (a https://play.google.com/store/apps/details?id=com.popupbits.flutteruichallenges)Flutter UI Challenges(/a)"),
                Space(),
                RaisedButton(
                  child: Text("About this app"),
                  onPressed: () async {
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();
                    showAboutDialog(
                        context: context,
                      applicationIcon: AppIcons.birthday,
                      applicationName: packageInfo.appName,
                      applicationVersion: "${packageInfo.version} (build ${packageInfo.buildNumber})",
                    );
                  },
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
