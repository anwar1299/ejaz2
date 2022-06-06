import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  int selectedTapIndex = 0;
  bool updated = false;

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments;
    if (data != null && !updated) {
      selectedTapIndex = (data as Map<String, Object>)['selected_index'] as int;
      updated = true;
    }
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        title: PageTitle(
          title: selectedTapIndex == 0
              ? 'My Training Courses'
              : 'Training Courses',
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
                      'Presented',
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
                    future: FirebaseServices().getMyCourses(),
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
                        if (selectedTapIndex == 0 && futureCourses.isEmpty) {
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
                        if (selectedTapIndex == 1 && pastCourses.isEmpty) {
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
                            return FutureBuilder<bool>(
                                future: FirebaseServices().isRated(course),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final isRated = snapshot.data;
                                    return CourseCard(
                                      image: course['image'],
                                      name: course['name'],
                                      date: course['startDate']
                                          .toDate()
                                          .toString()
                                          .split(' ')[0],
                                      showExtraButton: selectedTapIndex != 0,
                                      extraButtonColor:
                                          isRated! ? kAccentColor : Colors.red,
                                      extraButtonTitle:
                                          isRated ? 'Certificate' : 'Rate',
                                      onPressed: () async {
                                        if (selectedTapIndex == 0) {
                                          Navigator.pushNamed(
                                              context, '/course_details',
                                              arguments: course);
                                        } else {
                                          if (isRated) {
                                            Navigator.pushNamed(
                                                context, '/certificate',
                                                arguments: course);
                                          } else {
                                            Navigator.pushNamed(
                                                context, '/rating',
                                                arguments: course);
                                          }
                                        }
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                });
                          },
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: kTitlesFontSize,
                            ),
                          ),
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
