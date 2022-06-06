 /*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainee_training_courses/constants/constants.dart';
import 'package:trainee_training_courses/ui/widgets/widgets.dart';

class CourseDetailsPage extends StatefulWidget {
  const CourseDetailsPage({Key? key}) : super(key: key);

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  bool isRegistered = false;
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments;

    String date = '2022/7/3';
    String time = '10 : 30';
    int days = 1;
    int hours = 2;
    String hall = 'West hall';
    bool showButtons = true;

    if (data != null && (data as Map)['details'] != null) {
      showButtons = false;
    }

    if (data != null && (data as Map)['details'] == null) {
      int _timeDropdownValue = (data)['time'];

      date = data['date'];
      days = data['days'];
      hours = data['hours'];

      switch (data['halls']) {
        case 0:
          hall = 'West hall';
          break;
        case 1:
          hall = 'East hall';
          break;
        case 2:
          hall = 'North hall';
          break;
      }

      time = '${10 + _timeDropdownValue} : ${30 + _timeDropdownValue}';
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
                                      DetailsWidget(
                                        icon: Icons.place,
                                        title: hall,
                                      ),
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
                          GestureDetector(
                            onTap: () {
                              // todo: implement navigation
                              Navigator.pushNamed(context, '/cv');
                            },
                            child: Text(
                              'Dr. Amal saeed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: kPresenterNameTitle,
                              ),
                            ),
                          ),
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
                            child: Text(
                              'Geo club',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: kTitlesFontSize,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Training course topics',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: kTextFontSize,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const _TopicWidget(topic: 'What is Time Management'),
                          const _TopicWidget(topic: 'How to Time Management'),
                          const _TopicWidget(topic: 'Why Time Management'),
                          const SizedBox(height: 16),
                          Text(
                            'requirments',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: kTextFontSize * 0.8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Internet, Pens,\nnotebook',
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
          Expanded(
            child: showButtons
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style:
                  TextButton.styleFrom(backgroundColor: Colors.white),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 32,
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isRegistered = !isRegistered;
                    });
                  },
                  style:
                  TextButton.styleFrom(backgroundColor: Colors.amber),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 32,
                    ),
                    child: Text(
                      !isRegistered
                          ? 'Registration'
                          : 'Cancel Registration',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
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
 */