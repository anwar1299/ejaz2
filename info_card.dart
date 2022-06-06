import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kDefaultVerticalPadding * 2.5,
      width: getScreenWidth(context) * 0.6,
      decoration: BoxDecoration(
        border: Border.all(
          color: kPrimaryColor,
          width: 2,
        ),
      ),
      padding: EdgeInsets.only(left: kDefaultHorizontalPadding * 0.75),
      child: Row(
        children: [
          Container(
            width: (getScreenWidth(context) * 0.6) * 0.25,
            height: double.infinity,
            color: kPrimaryColor,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: kTitlesFontSize * 1.2,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                content,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: kTextFontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
