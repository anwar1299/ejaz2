import 'package:app/services/firebase_services.dart';
import 'package:app/ui/pages/cv_screen.dart';
import 'package:app/ui/pages/presenter_home_page.dart';
import 'package:app/ui/pages/singup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ui/pages/certificate_page.dart';
import '../ui/pages/club_courses_page.dart';
import '../ui/pages/clubs_screen.dart';
import '../ui/pages/clup_admin_screen.dart';
import '../ui/pages/login_Screen.dart';
import '../ui/pages/presenter_my_courses_page.dart';
import '../ui/pages/presenter_pages.dart';
import '../ui/pages/subscribes_screen.dart';
import '../ui/pages/supervisor_screen2.dart';
import 'enums.dart';

// constant colors
const Color kPrimaryColor = Colors.teal;
const Color kSecondaryColor = Color(0xFFFFFFFF);
const Color kAccentColor = Color(0xFFFFBA00);
const Color kGreyColor = Colors.grey;

// constatn padding
final kDefaultHorizontalPadding = ScreenUtil().setWidth(20);
final kDefaultVerticalPadding = ScreenUtil().setHeight(20);

// Icon size
const double kDefaultIconSize = 30;

// font sizes
final kTitlesFontSize = 16.sp;
final kTextFontSize = 14.sp;
final kLabelFontSize = 12.sp;
final kCourseTitleFontSize = 24.sp;
final kPresenterNameTitle = 20.sp;
final kUsernameFontSize = 24.sp;
final kStepperFontSize = 10.sp;

// width & height constants
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// Routes
var routes = {
  '/': (context) => const HomePage(),
  '/modification': (context) => const ModificationPage(),
  //'/clubs': (context) => const ClubsPage(),
  '/courses': (context) => const CoursesPage(),
  '/order_status': (context) => const OrderStatusPage(),
  '/info': (context) => const InfoPage(),
  '/notifications': (context) => const NotificationsPage(),
  '/rating': (context) => const RatingPage(),
  '/course_details': (context) => CourseDetailsPage(),
  '/club_info': (context) => const ClubInformationPage(),
  '/cv': (context) => const CvScreen(),
  '/login': (context) => const LoginScreen(),
  '/clubs': (context) => const ClubAdminScreen(),
  '/supervise': (context) => const SupervisorScreen2(),
  '/register': (context) => const SingupPage(),
  '/supervisor_clubs': (context) => const ClubsScreen(),
  '/requestNewCourse': (context) => PresenterRequestPage(),
  '/certificate': (context) => const CertificatePage(),
  '/club_courses': (context) => const ClubCoursesPage(),
  '/club_subscribers': (context) => const SubscribesScreen(),
  '/presenter_my_courses_page': (context) => const PresenterMyCoursesPage(),
  '/addLocation': (context) => AddLocationPage(),
};

class AddLocationPage extends StatelessWidget {
  AddLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add location to firebase using dailog with one text field
          // crete text controller
          final _textController = TextEditingController();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text('Add Location'),
                  content: TextField(
                    controller: _textController,
                    decoration: InputDecoration(hintText: 'Location'),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        // add location to firebase
                        FirebaseServices().addLocation(_textController.text);
                        // close dialog
                        Navigator.pop(context);
                      },
                      child: Text('Add'),
                    )
                  ]);
            },
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Add Location'),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: FirebaseServices().getLocations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].get('name')),
                      // delete on tab the tealing
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            snapshot.data![index].reference
                                .delete()
                                .then((value) {
                              // topsnakbar
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Location deleted'),
                              ));
                            });
                          }),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// profile page options list
final List profileOptions = [
  {
    'icon': Icons.assignment_ind_outlined,
    'title': 'My Clubs',
    'route': '/clubs',
  },
  {
    'icon': Icons.school_outlined,
    'title': 'My training courses',
    'route': '/courses',
  },
  {
    'icon': Icons.settings_rounded,
    'title': 'Settings',
    'route': '/info',
  },
  {
    'icon': Icons.logout_rounded,
    'title': 'Logout',
    'route': '/login',
  },
];

// profile page options list
final List managerOptions = [
  {
    'icon': Icons.assignment_ind_outlined,
    'title': 'Clubs',
    'route': '/clubs',
  },
  {
    'icon': Icons.school_outlined,
    'title': 'Supervise',
    'route': '/supervise',
  },

  {
    'icon': Icons.settings_rounded,
    'title': 'Settings',
  },
  {
    'icon': Icons.logout_rounded,
    'title': 'Logout',
  },
  // add room
  {
    'icon': Icons.add_circle_outline,
    'title': 'Add room',
    'route': '/addLocation',
  },
];
final List supervisorOptions = [
  {
    'icon': Icons.assignment_ind_outlined,
    'title': 'Clubs',
    'route': '/supervisor_clubs',
  },
  {
    'icon': Icons.badge,
    'title': 'CV',
    'route': '/cv',
  },
  {
    'icon': Icons.settings_rounded,
    'title': 'Settings',
  },
  {
    'icon': Icons.logout_rounded,
    'title': 'Logout',
  },
];

final presenterOptions = [
  {
    'icon': Icons.assignment_ind_outlined,
    'title': 'Clubs',
    'route': '/clubs',
  },
  {
    'icon': Icons.school_outlined,
    'title': 'Training courses',
    'route': '/supervise',
  },
  {
    'icon': Icons.settings_rounded,
    'title': 'Settings',
  },
  {
    'icon': Icons.logout_rounded,
    'title': 'Logout',
  },
  {
    'icon': Icons.assignment_ind_outlined,
    'title': 'view CV',
    'route': '/cv',
  },
];

// modification page options list
final List modificationOptions = [
  {
    'icon': Icons.add_photo_alternate_outlined,
    'title': 'Change Image',
  },
  {
    'icon': Icons.phone_rounded,
    'title': 'Change Email',
  },
  {
    'icon': Icons.lock_rounded,
    'title': 'Change the password',
  },
  {
    'icon': Icons.person_rounded,
    'title': 'Name',
    'trailing': Icons.arrow_forward_rounded
  },
  {
    'icon': Icons.phone,
    'title': 'Phone Number',
    'trailing': Icons.arrow_forward_rounded
  },
];

// Settings sheet options list
final List settingOptions = [
  {
    'icon': Icons.public_rounded,
    'title': 'Language',
  },
  {
    'icon': Icons.notifications_none_rounded,
    'title': 'Notices',
  },
  {
    'icon': Icons.phone_in_talk_rounded,
    'title': 'Help',
  },
];

// Available clubs list
final List availableClubs = [
  {
    'image': 'assets/club.jpg',
    'name': 'Club Name',
    'id': 'Club ID',
  },
  {
    'image': 'assets/club.jpg',
    'name': 'Club Name',
    'id': 'Club ID',
  },
  {
    'image': 'assets/club.jpg',
    'name': 'Club Name',
    'id': 'Club ID',
  },
  {
    'image': 'assets/club.jpg',
    'name': 'Club Name',
    'id': 'Club ID',
  },
];

// Current courses list
final List currentCourses = [
  {
    'image': 'assets/user.png',
    'name': 'Course',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Course',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Course',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Course',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Coursee',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Course',
    'date': '01234567',
  },
];

// Previous courses list
final List previousCourses = [
  {
    'image': 'assets/course.jpg',
    'name': 'Previous',
    'date': '98765432',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Previous',
    'date': '98765432',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Previous',
    'date': '98765432',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Previous',
    'date': '98765432',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Previous',
    'date': '98765432',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Previous',
    'date': '98765432',
  },
];

final List searchList = [
  {
    'image': 'assets/user.png',
    'name': 'Course',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Course',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Course',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Course',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Coursee',
    'date': '01234567',
  },
  {
    'image': 'assets/course.jpg',
    'name': 'Course',
    'date': '01234567',
  },
];

// Notifications list
final List notificationsList = [
  {'type': NotificationType.success},
  {'type': NotificationType.newCourse},
  {'type': NotificationType.warning},
  {'type': NotificationType.reminder},
  {'type': NotificationType.success},
  {'type': NotificationType.warning},
  {'type': NotificationType.success},
];

// Rating list
final List ratingList = [
  {
    'icon': Icons.person_rounded,
    'title': 'Overall evaluation',
    'rate': 0.0,
  },
  {
    'icon': Icons.menu_book_rounded,
    'title': 'Course Content',
    'rate': 0.0,
  },
  {
    'icon': Icons.schedule_rounded,
    'title': 'Time',
    'rate': 0.0,
  },
  {
    'icon': Icons.person_rounded,
    'title': 'Presenter',
    'rate': 0.0,
  },
  {
    'icon': Icons.place_outlined,
    'title': 'Location',
    'rate': 0.0,
  },
  {
    'icon': null,
    'title': 'Extent of benefit',
    'rate': 0.0,
  },
  {
    'icon': null,
    'title': 'Extent interaction',
    'rate': 0.0,
  },
];

// Settings sheet options list
final List courseDetailsList = [
  {
    'icon': Icons.account_balance_rounded,
    'title': 'club name',
  },
  {
    'icon': Icons.person_rounded,
    'title': 'supervisor\'s name',
  },
  {
    'icon': Icons.person_rounded,
    'title': 'coach\'s name',
  },
  {
    'icon': Icons.person_rounded,
    'title': 'Subscribers',
  },
];

// Settings sheet options list
final List ordersList = [
  {
    'currentStage': 1,
    'failedStages': <int>[],
  },
  {
    'currentStage': 4,
    'failedStages': <int>[],
  },
  {
    'currentStage': 5,
    'failedStages': <int>[],
  },
  {
    'currentStage': 3,
    'failedStages': <int>[4, 5],
  },
  {
    'currentStage': 1,
    'failedStages': <int>[],
  },
];
