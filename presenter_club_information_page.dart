import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class ClubInformationPage extends StatelessWidget {
  const ClubInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        leading: const SizedBox(),
        actions: const [
          AppBarBackButton(),
        ],
        title: const PageTitle(
          title: 'Club Information',
          titleColor: kSecondaryColor,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      'The Title of Training Course',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: kCourseTitleFontSize,
                      ),
                    ),
                  ),
                  SizedBox(width: kDefaultHorizontalPadding * 0.5),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultVerticalPadding),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/course.jpg',
                        width: getScreenWidth(context) * 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            'A club of people intrested in\ngeology and for them',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: kPresenterNameTitle,
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: SvgPicture.asset(
                    'assets/club_info_bg.svg',
                    height: MediaQuery.of(context).size.height * 0.55,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Supervisor',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                            Text(
                              'Dr.Amel Ahmed',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                            Text(
                              'amal@gmail.com',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'President',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                            Text(
                              'Rola Saed',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                            Text(
                              'rola@gmail.com',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Location',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                            Text(
                              'west hall',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: kDefaultHorizontalPadding),
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () {
                              // Go to club courses screen
                              Navigator.pushNamed(context, '/courses');
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: kAccentColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: kDefaultHorizontalPadding,
                                vertical: kDefaultVerticalPadding * 0.5,
                              ),
                              child: Text(
                                'Club training courses',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: kTextFontSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
