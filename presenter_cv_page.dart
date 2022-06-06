import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../widgets/appbar_back_button.dart';
import '../widgets/page_title.dart';

class CvPage extends StatelessWidget {
  const CvPage({Key? key}) : super(key: key);

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
          title: 'CV',
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
                      'Dr. Amal Eesa',
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
                        width: getScreenWidth(context) * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
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
                              'PhD in Biology',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'President of Biology\nMagazine',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'amal@gmail.com',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
