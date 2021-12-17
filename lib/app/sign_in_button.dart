import 'package:flutter/material.dart';
import 'package:vendors_app/common_widgets/custom_raised_button.dart';
import 'package:vendors_app/main.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    @required String text,
    @required IconData icon,
    Color color,
    Color textColor,
    VoidCallback onPressed,
    double height=52,
    double iconSize=20,
    double textSize=15,
  })  : assert(text != null),
        assert(icon != null),
        super(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon,size: iconSize,color: petColor,),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
              ),
            ),
            Opacity(
              opacity: 0.0,
              child: Icon(icon,size: iconSize,color:petColor,),
            ),
          ],
        ),
        color: color,
        onPressed: onPressed,
        height: height,
      );
}

