import 'package:app/services/firebase_services.dart';
import 'package:app/ui/widgets/club_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/constants.dart';
import '../../pages/admin_club_detail_page.dart';
import '../course_card.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 1.0,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Climb the ladder of success\nand make your mark',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: kTitlesFontSize,
                    ),
                  ),
                  SizedBox(height: kDefaultVerticalPadding),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.asset('assets/ladder.svg'),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: kDefaultVerticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: kDefaultHorizontalPadding),
                        child: Text(
                          'Clubs',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: kTitlesFontSize,
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultVerticalPadding),
                      SizedBox(
                        height: getScreenHeight(context) * 0.22,
                        child: FutureBuilder<List<QueryDocumentSnapshot>>(
                            future: FirebaseServices().getClubs(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final clubs = snapshot.data ?? [];

                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1,
                                    crossAxisCount: 1,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.only(
                                      left: kDefaultHorizontalPadding * 0.5),
                                  itemCount: clubs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final club = clubs[index];
                                    return Container(
                                      width: getScreenWidth(context) * 0.4,
                                      height: getScreenWidth(context) * 0.4,
                                      margin: EdgeInsets.only(
                                          right:
                                              kDefaultHorizontalPadding * 0.5),
                                      child: ClubCard(
                                        image: club['image'].toString(),
                                        name: club['name'],
                                        onPressed: () {
                                          final route = MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminClubDetailPage(
                                                      club: club));
                                          Navigator.push(context, route);
                                        },
                                        id: club['id'],
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                print(snapshot.error);
                                return Text('${snapshot.error}');
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                      SizedBox(height: kDefaultVerticalPadding),
                      Padding(
                        padding:
                            EdgeInsets.only(left: kDefaultHorizontalPadding),
                        child: Text(
                          'New training courses',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: kTitlesFontSize,
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultVerticalPadding),
                      SizedBox(
                        height: getScreenHeight(context) * 0.22,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseServices().getCoursesByState(4),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final courses = snapshot.data?.docs ?? [];

                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1,
                                    crossAxisCount: 1,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.only(
                                      left: kDefaultHorizontalPadding * 0.5),
                                  itemCount: courses.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final course = courses[index];
                                    return Container(
                                      width: getScreenWidth(context) * 0.4,
                                      height: getScreenWidth(context) * 0.4,
                                      margin: EdgeInsets.only(
                                          right:
                                              kDefaultHorizontalPadding * 0.5),
                                      child: CourseCard(
                                        image: course['image'].toString(),
                                        name: course['name'],
                                        date: course['startDate']
                                            .toDate()
                                            .toString()
                                            .split(' ')[0],
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/course_details',
                                              arguments: course);
                                        },
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                print(snapshot.error);
                                return Text('${snapshot.error}');
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
