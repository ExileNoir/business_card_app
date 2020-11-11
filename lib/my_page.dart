import 'package:deseure_steven_card/constants.dart';
import 'package:deseure_steven_card/reusable_card.dart';
import 'package:deseure_steven_card/reusable_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBox(30),
                Expanded(
                  flex: 0,
                  child: ReusableIcons(
                    color: Colors.teal,
                    cardChild: CircleAvatar(
                      backgroundImage: ExactAssetImage('images/steven.jpg'),
                      radius: 60,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      textName(),
                      textJobDescription(),
                      SizedBox(
                        height: 20.0,
                        width: 150.0,
                        child: Divider(
                          color: Colors.teal.shade100,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      sizedBox(60),
                      ReusableCard(
                        onPress: () {
                          launch("tel://$kMobileNumber");
                          // FlutterPhoneDirectCaller.callNumber(kMobileNumber);
                        },
                        icon: Icons.phone_android,
                        userInfo: '$kMobileNumberText',
                      ),
                      ReusableCard(
                        icon: Icons.mail,
                        userInfo: '$kEmail',
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ReusableIcons(
                          onPress: () => _launchURL('$kGitHub'),
                          color: Colors.teal,
                          cardChild: Icon(
                            FontAwesomeIcons.github,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableIcons(
                          onPress: () => _launchURL('$kBitBucket'),
                          color: Colors.teal,
                          cardChild: Icon(
                            FontAwesomeIcons.bitbucket,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Text textJobDescription() {
    return Text(
      'JAVA DEVELOPER',
      style: TextStyle(
        color: Colors.teal.shade100,
        fontFamily: 'Source Sans Pro',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.5,
      ),
    );
  }

  Text textName() {
    return Text(
      'Steven Deseure',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Pacifico',
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  SizedBox sizedBox(final double height) {
    return SizedBox(height: height);
  }

  _launchURL(final String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
