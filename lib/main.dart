import 'file:///C:/Users/Steven/Desktop/PROJECTS/CourseBook/FlutterCourse/deseure_steven_card/lib/view/my_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyBusinessCard());
}

class MyBusinessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.teal,
      ),
      home: MyPage(),
    );
  }
}
