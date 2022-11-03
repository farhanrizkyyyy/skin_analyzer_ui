// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:skin_analyzer/configs/pallete.config.dart';

class Button extends StatefulWidget {
  String text;
  Widget? prefixIcon;
  Function()? onPressed;
  bool isBackgroundFilled;
  EdgeInsetsGeometry? padding;

  Button({
    required this.text,
    this.prefixIcon,
    this.onPressed,
    this.isBackgroundFilled = true,
    this.padding,
    super.key,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.isBackgroundFilled ? Pallete.primary : Colors.white,
        ),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(widget.padding),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.prefixIcon ?? SizedBox(),
          widget.prefixIcon != null ? SizedBox(width: 8) : Container(),
          Text(
            widget.text,
            style: _textStyle(),
          ),
        ],
      ),
    );
  }

  _textStyle() {
    return TextStyle(
      color: widget.isBackgroundFilled ? Colors.white : Pallete.primary,
      fontWeight: FontWeight.w700,
    );
  }
}
