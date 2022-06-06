import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        title: const PageTitle(
          title: 'Rating (training course)',
          titleColor: kSecondaryColor,
        ),
        leading: const SizedBox(),
        actions: const [AppBarBackButton()],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultHorizontalPadding,
          vertical: kDefaultVerticalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: ratingList
                  .map<Widget>(
                    (ratingItem) => ServiceRating(
                      icon: ratingItem['icon'],
                      title: ratingItem['title'],
                      rate: ratingItem['rate'],
                      onRateChanged: (rate) {
                        ratingItem['rate'] = rate;
                      },
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: kDefaultVerticalPadding * 2),
            SubmitButton(
              title: 'Submit',
              radius: 15,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
