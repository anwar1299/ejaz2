import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.radius,
  }) : super(key: key);
  final String title;
  final Function() onPressed;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: kAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultHorizontalPadding * 2.5,
          vertical: kDefaultVerticalPadding * 0.5,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: kTitlesFontSize,
          ),
        ),
      ),
    );
  }
}
