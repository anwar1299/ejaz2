import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: const SizedBox(),
        actions: const [AppBarBackButton()],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultHorizontalPadding,
                vertical: kDefaultVerticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: const AssetImage('assets/user.jpg'),
                    radius: kDefaultHorizontalPadding * 2.5,
                  ),
                  SizedBox(height: kDefaultVerticalPadding * 2),
                  Text(
                    'Aml Salem',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: kTitlesFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: kDefaultVerticalPadding * 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '058XXXXXXX',
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: kTextFontSize,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: kDefaultHorizontalPadding),
                      Text(
                        '43800XX',
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: kTextFontSize,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: kDefaultHorizontalPadding),
                      Text(
                        'aml.99@gmail.com',
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: kTextFontSize,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: getScreenWidth(context),
              color: kSecondaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultHorizontalPadding,
                vertical: kDefaultVerticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  InfoCard(
                    title: '20',
                    content: 'Club',
                  ),
                  InfoCard(
                    title: 'CV',
                    content: 'Aml Salem',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
