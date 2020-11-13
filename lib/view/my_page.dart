import 'dart:async';
import 'dart:io';

import 'package:deseure_steven_card/icons/cv_one_icons.dart';
import 'file:///C:/Users/Steven/Desktop/PROJECTS/CourseBook/FlutterCourse/deseure_steven_card/lib/view/pdf_view_page.dart';
import 'file:///C:/Users/Steven/Desktop/PROJECTS/CourseBook/FlutterCourse/deseure_steven_card/lib/reusables/reusable_card.dart';
import 'file:///C:/Users/Steven/Desktop/PROJECTS/CourseBook/FlutterCourse/deseure_steven_card/lib/reusables/reusable_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'file:///C:/Users/Steven/Desktop/PROJECTS/CourseBook/FlutterCourse/deseure_steven_card/lib/constants/constants.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

final String assetName = 'assets/curriculum-vitae.svg';
final Widget svg = SvgPicture.asset(assetName, semanticsLabel: 'CV');

class _MyPageState extends State<MyPage> {
  String assetPdfPath = '';

  @override
  void initState() {
    super.initState();
    getFileFromAsset('assets/CV.pdf').then((value) {
      setState(() {
        assetPdfPath = value.path;
        print(assetPdfPath + 'Hello  i am here');
        print('init state'); //debug feature
      });
    });
  }

  Future<File> getFileFromAsset(final String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      final File file = File('${dir.path}/CV.pdf');

      final File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception('Error opening asset file');
    }
  }

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
                      Expanded(
                        child: ReusableIcons(
                          onPress: () => _launchURL('$kLinkedIn'),
                          color: Colors.teal,
                          cardChild: Icon(
                            FontAwesomeIcons.linkedin,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableIcons(
                          onPress: () {
                            if (assetPdfPath != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PdfViewPage(path: assetPdfPath)));
                            }
                          },
                          color: Colors.teal,
                          cardChild: Icon(
                            CvOne.curriculum_vitae__4_,
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
