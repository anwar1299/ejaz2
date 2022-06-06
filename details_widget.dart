import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: kDefaultHorizontalPadding * 0.5,
        bottom: kDefaultVerticalPadding * 0.5,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.teal,
          ),
          SizedBox(width: kDefaultHorizontalPadding),
          Text(
            title,
            style: TextStyle(
              color: Colors.teal,
              fontSize: kTextFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
