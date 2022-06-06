import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ClubCard extends StatelessWidget {
  const ClubCard({
    Key? key,
    required this.image,
    required this.name,
    required this.id,
    required this.onPressed,
  }) : super(key: key);
  final String image;
  final String name;
  final String id;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: kDefaultHorizontalPadding * 1.5,
                right: kDefaultHorizontalPadding * 1.5,
                top: kDefaultVerticalPadding * 0.5,
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    width: getScreenWidth(context) * 0.25,
                    height: getScreenWidth(context) * 0.25,
                  ),
                ),
              ),
            ),
            SizedBox(height: kDefaultVerticalPadding * 0.5),
            Text(
              name,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: kTitlesFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              id,
              style: TextStyle(
                color: kPrimaryColor.withOpacity(0.5),
                fontSize: kTextFontSize,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
