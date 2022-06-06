import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class ClubCoursesPage extends StatefulWidget {
  const ClubCoursesPage({Key? key}) : super(key: key);

  @override
  State<ClubCoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<ClubCoursesPage> {
  int selectedTapIndex = 0;

  @override
  Widget build(BuildContext context) {
    // get club from arguments
    final String clubId = ModalRoute.of(context)?.settings.arguments as String;
    print('club id: $clubId');
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: PageTitle(
          title: 'Club Training Courses',
        ),
        actions: const [
          AppBarBackButton(
            buttonColor: kPrimaryColor,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultHorizontalPadding,
          vertical: kDefaultVerticalPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (selectedTapIndex == 1) {
                        setState(() {
                          selectedTapIndex = 0;
                        });
                      }
                    },
                    child: Text(
                      'Upcoming',
                      style: TextStyle(
                        color: selectedTapIndex == 0
                            ? kSecondaryColor
                            : Colors.grey,
                        fontSize: kTitlesFontSize,
                      ),
                    ),
                  ),
                  SizedBox(width: kDefaultHorizontalPadding),
                  TextButton(
                    onPressed: () {
                      if (selectedTapIndex == 0) {
                        setState(() {
                          selectedTapIndex = 1;
                        });
                      }
                    },
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        color: selectedTapIndex == 1
                            ? kSecondaryColor
                            : Colors.grey,
                        fontSize: kTitlesFontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
                child: FutureBuilder<List<QueryDocumentSnapshot>>(
                    future: FirebaseServices().getCoursesByClubId(clubId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final courses = snapshot.data;
                        // get future courses by start date
                        // check if course is empty
                        if (courses!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 60,
                                  color: kSecondaryColor,
                                ),
                                SizedBox(height: kDefaultVerticalPadding),
                                Text(
                                  'No courses found',
                                  style: TextStyle(
                                    fontSize: kTitlesFontSize,
                                  ),
                                ),
                                SizedBox(height: kDefaultVerticalPadding),
                                Text(
                                  'You have no courses yet',
                                  style: TextStyle(
                                    fontSize: kTitlesFontSize,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        final futureCourses = courses
                            .where((course) => (course['startDate'])
                                .toDate()
                                .isAfter(DateTime.now()))
                            .toList();
                        // get past courses by end date
                        final pastCourses = courses
                            .where((course) => (course['startDate'])
                                .toDate()
                                .isBefore(DateTime.now()))
                            .toList();
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.9,
                            crossAxisCount: 2,
                            mainAxisSpacing: kDefaultVerticalPadding * 0.5,
                            crossAxisSpacing: kDefaultHorizontalPadding * 0.5,
                          ),
                          itemCount: selectedTapIndex == 0
                              ? futureCourses.length
                              : pastCourses.length,
                          itemBuilder: (BuildContext context, int index) {
                            final course = selectedTapIndex == 0
                                ? futureCourses[index]
                                : pastCourses[index];
                            return CourseCard(
                              image: course['image'],
                              name: course['name'],
                              date: course['startDate']
                                  .toDate()
                                  .toString()
                                  .split(' ')[0],
                              extraButtonColor: kAccentColor,
                              onPressed: () {
                                Navigator.pushNamed(context, '/course_details',
                                    arguments: course);
                              },
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
