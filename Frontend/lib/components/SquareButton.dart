import 'package:flutter/material.dart';
import 'package:project_bleh/constants.dart';

class SquareButton extends StatelessWidget {
  SquareButton(
      {@required this.title,
      @required this.icon,
      this.onTap,
      @required this.iconHeroTag});

  final String title;
  final Icon icon;
  final Function onTap;
  final String iconHeroTag;
  //final String cardTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MaterialButton(
        onPressed: onTap,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kButtonBorderRadius),
        ),
        height: 150.0,
        //margin: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              child: icon,
              tag: iconHeroTag,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: kButtonTextSize,
                fontWeight: FontWeight.w300,
                color: kDarkTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
