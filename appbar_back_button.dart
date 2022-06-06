import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AppBarBackButton extends StatefulWidget {
  const AppBarBackButton({
    Key? key,
    this.buttonColor,
  }) : super(key: key);
  final Color? buttonColor;

  @override
  State<AppBarBackButton> createState() => _AppBarBackButtonState();
}

class _AppBarBackButtonState extends State<AppBarBackButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      splashRadius: 20,
      icon: RotatedBox(
        quarterTurns: 1,
        child: Icon(
          Icons.arrow_circle_up_rounded,
          size: kDefaultIconSize,
          color: widget.buttonColor ?? kSecondaryColor,
        ),
      ),
    );
  }
}
