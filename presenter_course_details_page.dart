import 'dart:io';

import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class CourseDetailsPage extends StatelessWidget {
  CourseDetailsPage({Key? key}) : super(key: key);
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // get value from arguments
    final QueryDocumentSnapshot courseName =
        ModalRoute.of(context)?.settings.arguments as QueryDocumentSnapshot;

    String date = '2022/7/3';
    String time = '10 : 30';
    int days = 1;
    String hours = '2';
    String hall = 'West hall';
    bool showButtons = false;

    if (courseName != null) {
      //int _timeDropdownValue = parseTime(data['date']);

      date = '${formatDate(parseTime(courseName['startDate']))}';
      // diff between start and end date
      days = parseTime(courseName['endDate'])
          .difference(parseTime(courseName['startDate']))
          .inDays;
      hours = courseName.get('hours');

      // switch (data['halls']) {
      //   case 0:
      //     hall = 'West hall';
      //     break;
      //   case 1:
      //     hall = 'East hall';
      //     break;
      //   case 2:
      //     hall = 'North hall';
      //     break;
      // }

      time =
          '${parseTime(courseName['time']).hour}:${parseTime(courseName['time']).minute}';
      showButtons = true;
    }

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
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultHorizontalPadding,
              vertical: kDefaultVerticalPadding,
            ),
            child: Text(
              'Time Management',
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: kCourseTitleFontSize,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: SvgPicture.asset('assets/background.svg'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: kDefaultVerticalPadding * 2),
                                  child: Column(
                                    children: [
                                      DetailsWidget(
                                        icon: Icons.description_outlined,
                                        title: date,
                                      ),
                                      DetailsWidget(
                                        icon: Icons.schedule_rounded,
                                        title: time,
                                      ),
                                      DetailsWidget(
                                        icon: Icons.schedule_rounded,
                                        title: '$days days',
                                      ),
                                      DetailsWidget(
                                        icon: Icons.schedule_rounded,
                                        title: '$hours hours',
                                      ),
                                      FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseServices()
                                              .getLocationById(
                                                  courseName.get('location')),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return DetailsWidget(
                                                icon: Icons.location_on_rounded,
                                                title:
                                                    snapshot.data!.get('name'),
                                              );
                                            } else {
                                              return const DetailsWidget(
                                                icon: Icons.location_on_rounded,
                                                title: 'Loading...',
                                              );
                                            }
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Presented By',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: kLabelFontSize,
                            ),
                          ),
                          const SizedBox(height: 4),
                          FutureBuilder<DocumentSnapshot>(
                              future: FirebaseServices()
                                  .getUserData(courseName.get('userId')),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!['name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: kPresenterNameTitle,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                    'Error Occured ${snapshot.error}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: kLabelFontSize,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    'Loading...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: kLabelFontSize,
                                    ),
                                  );
                                }
                              }),
                          const SizedBox(height: 16),
                          Text(
                            'Under supervision of',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: kLabelFontSize,
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              // todo: Implement Navigation
                              Navigator.pushNamed(context, '/club_info');
                            },
                            child: FutureBuilder<DocumentSnapshot?>(
                                future: FirebaseServices()
                                    .getSupervisorByClubId(
                                        courseName.get('club')),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: kTitlesFontSize,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    print(snapshot.error);
                                    return Text(
                                      'Error... ${snapshot.error}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: kLabelFontSize,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      'Loading...',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: kLabelFontSize,
                                      ),
                                    );
                                  }
                                }),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${courseName.get('topic')}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: kTextFontSize,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // const _TopicWidget(topic: 'What is Time Management'),
                          // const _TopicWidget(topic: 'How to Time Management'),
                          // const _TopicWidget(topic: 'Why Time Management'),
                          const SizedBox(height: 16),
                          Text(
                            'Requirements',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: kTextFontSize * 0.8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            (courseName.get('luxuries') as List).join(', '),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: kTextFontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (courseName.get('state') >= 3)
            Expanded(
              child: showButtons
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<bool>(
                            future: FirebaseServices().isSubscribed(courseName),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                bool? isSubscribed = snapshot.data;
                                return isSubscribed == true
                                    ? _SubscribeButton(
                                        courseName, true, context)
                                    : _SubscribeButton(
                                        courseName, false, context);
                              } else {
                                return Container();
                              }
                            }),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          if (courseName.get('state') <= 3)
            Expanded(
              child: showButtons
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // change coutse state to 2
                            courseName.reference.update({'state': 2});
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.amber),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 24,
                            ),
                            child: Text(
                              'Review',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () {
                            // change coutse state to 3
                            courseName.reference.update({'state': 4});
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 24,
                            ),
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () {
                            // change coutse state to 4
                            // dialog to write reason
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Reason'),
                                content: TextField(
                                  controller: _titleController,
                                ),
                                actions: [
                                  FlatButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: const Text('Confirm'),
                                    onPressed: () {
                                      // change coutse state to 4
                                      courseName.reference.update(
                                        {
                                          'state': 5,
                                          'reason': _titleController.text
                                        },
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                            //courseName.reference.update({'state': 5});
                          },
                          style:
                              TextButton.styleFrom(backgroundColor: Colors.red),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 24,
                            ),
                            child: Text(
                              'Reject',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }

  // firebase time stamp to date
  DateTime parseTime(dynamic date) {
    return Platform.isIOS ? (date as Timestamp).toDate() : (date as DateTime);
  }

  // format date to USA
  String formatDate(DateTime date) {
    return "${date.month}-${date.day}-${date.year}";
  }
}

_SubscribeButton(QueryDocumentSnapshot? courseName, bool isSubscribed,
    BuildContext context) {
  return TextButton(
    onPressed: () async {
      // store user name and id to array in course collection
      // then update the state of the course
      bool state = false;
      if (!isSubscribed) {
        state = await FirebaseServices().joinCourse(courseName);
      } else {
        state = await FirebaseServices().leaveCourse(courseName);
      }

      if (state) {
        showTopSnackBar(
            context,
            isSubscribed
                ? const CustomSnackBar.info(
                    message: 'You have unsubscribed from this course.')
                : const CustomSnackBar.success(
                    message: 'Successfully joined the course'));
      } else {
        showTopSnackBar(context,
            const CustomSnackBar.error(message: 'Failed to join the course'));
      }
    },
    style: TextButton.styleFrom(backgroundColor: Colors.amber),
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
      child: Text(
        isSubscribed ? 'Leave' : 'Join',
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}

class _TopicWidget extends StatelessWidget {
  const _TopicWidget({
    Key? key,
    required this.topic,
  }) : super(key: key);
  final String topic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '•',
          style: TextStyle(color: Colors.white, fontSize: kTitlesFontSize),
        ),
        const SizedBox(width: 10),
        Text(
          topic,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
