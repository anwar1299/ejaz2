import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key? key,
    required this.title,
    this.titleColor,
  }) : super(key: key);
  final String title;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: titleColor ?? kPrimaryColor,
        fontSize: kTitlesFontSize,
      ),
      textAlign: TextAlign.end,
    );
  }
}
