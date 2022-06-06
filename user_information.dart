import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({
    Key? key,
    required this.username,
    required this.phonenumber,
    required this.numberID,
  }) : super(key: key);
  final String username;
  final String phonenumber;
  final String numberID;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          username,
          style: const TextStyle(color: kPrimaryColor),
        ),
        SizedBox(
          height: kDefaultVerticalPadding * 0.2,
        ),
        Text(
          phonenumber,
          style: const TextStyle(color: kPrimaryColor),
        ),
        SizedBox(
          height: kDefaultVerticalPadding * 0.2,
        ),
        Text(
          numberID,
          style: const TextStyle(color: kPrimaryColor),
        ),
      ],
    );
  }
}
