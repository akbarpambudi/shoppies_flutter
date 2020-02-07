import 'package:flutter/material.dart';

class LoginButtonStyle {
  Color buttonColor;
  Color textColor;

  LoginButtonStyle({this.buttonColor, this.textColor});

  LoginButtonStyle copyWith({Color buttonColor, Color textColor}) {
    this.buttonColor = buttonColor ?? this.buttonColor;
    this.textColor = textColor ?? this.textColor;
    return this;
  }

  LoginButtonStyle concat(LoginButtonStyle loginButtonStyle) {
    this.copyWith(buttonColor: this.buttonColor, textColor: this.textColor);
    return this;
  }
}

class LoginButton extends StatelessWidget {
  final Function onPress;
  final String label;
  final LoginButtonStyle style;
  const LoginButton(
      {Key key, @required this.onPress, @required this.label, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = new LoginButtonStyle(
        buttonColor: Theme.of(context).primaryColor, textColor: Colors.white);
    if (style != null) {
      style = style.concat(this.style);
    }
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: style.buttonColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: onPress,
          child: Text(
            label,
            style: TextStyle(color: style.textColor),
          ),
        ));
  }
}
