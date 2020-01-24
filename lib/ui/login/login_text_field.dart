import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String title;
  final bool asPassword;
  final IconData icon;
  final Function(String) onTextSubmitted;
  const LoginTextField(
      {Key key,
      @required this.title,
      this.asPassword = false,
      this.icon,
      this.onTextSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: asPassword,
      onSaved: onTextSubmitted,
      decoration: InputDecoration(
          hintText: title,
          prefixIcon: Icon(icon),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }
}
