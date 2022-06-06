import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  // get arguments from previous page

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as QueryDocumentSnapshot;
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
              onPressed: () async {
                // remove iteam from list
                final list =
                    ratingList.map((item) => item..remove("icon")).toList();
                // save multiple ratings to firestore
                double totalScores = 0.0;
                // looping over data array
                list.forEach((item) {
                  //getting the key direectly from the name of the key
                  totalScores += item["rate"];
                });

                print(totalScores);
                // save to firestore
                final state1 = await FirebaseServices().saveRating(
                  arguments,
                  totalScores,
                );

                final state = await FirebaseServices()
                    .saveRatingToRatings(arguments, list);
                if (state) {
                  Navigator.pop(context);
                } else {
                  showTopSnackBar(
                      context, const CustomSnackBar.error(message: 'Error'));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
