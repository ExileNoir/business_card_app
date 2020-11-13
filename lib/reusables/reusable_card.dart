import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Function onPress;
  final IconData icon;
  final String userInfo;

  ReusableCard({this.onPress, @required this.icon, @required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            userInfo,
            style: TextStyle(
              color: Colors.teal.shade900,
              fontFamily: 'Source Sans Pro',
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
