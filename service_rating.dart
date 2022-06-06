import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constants/constants.dart';

class ServiceRating extends StatelessWidget {
  const ServiceRating({
    Key? key,
    this.icon,
    required this.title,
    required this.rate,
    required this.onRateChanged,
  }) : super(key: key);
  final IconData? icon;
  final String title;
  final double rate;
  final Function(double) onRateChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color: kSecondaryColor,
            )
          : const SizedBox(
              width: 24,
              height: 24,
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: kTextFontSize,
            ),
          ),
          RatingBar.builder(
            initialRating: rate,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 20,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: onRateChanged,
          ),
        ],
      ),
    );
  }
}
