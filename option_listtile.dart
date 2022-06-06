import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class OptionListTile extends StatelessWidget {
  const OptionListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.dividerColor,
    required this.onPressed,
    this.titleColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Color? dividerColor;
  final Color? titleColor;
  final Function() onPressed; // on list item pressed event

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData(
            splashColor: Colors.grey.withOpacity(0.5),
            highlightColor: Colors.grey.withOpacity(0.5),
          ),
          child: ListTile(
            onTap: onPressed,
            contentPadding: EdgeInsets.symmetric(
              horizontal: kDefaultHorizontalPadding,
              vertical: kDefaultVerticalPadding * 0.4,
            ),
            leading: Icon(
              icon,
              color: titleColor ?? kGreyColor,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: titleColor ?? kGreyColor,
                fontSize: kTextFontSize,
              ),
            ),
          ),
        ),
        Divider(
          color: dividerColor ?? Colors.grey.withOpacity(0.5),
          height: 0.05,
        ),
      ],
    );
  }
}
