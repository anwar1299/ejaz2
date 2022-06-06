import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: const SizedBox(),
        title: const PageTitle(
          title: 'Notifications',
          titleColor: kSecondaryColor,
        ),
        actions: const [AppBarBackButton()],
      ),
      body: SizedBox(
        width: getScreenWidth(context),
        height: getScreenHeight(context),
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: FirebaseServices().getReviewCourses(),
          builder:
              (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final notification = snapshot.data![index];
                  return Card(child: Text('${notification.get('name')}'));
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        // child: ListView.builder(
        //   padding: const EdgeInsets.all(8),
        //   itemCount: notificationsList.length,
        //   itemBuilder: (context, index) {
        //     var notification = notificationsList[index];
        //     IconData icon;
        //     String title;
        //     Color color;
        //     // Determine the values of icons and title
        //     switch (notification['type']) {
        //       case NotificationType.success:
        //         color = Colors.green;
        //         title = 'Success';
        //         icon = Icons.check_circle_outline_rounded;
        //         break;
        //       case NotificationType.newCourse:
        //         color = Colors.blue;
        //         title = 'New Course';
        //         icon = Icons.fiber_new_outlined;
        //         break;
        //       case NotificationType.warning:
        //         color = Colors.red;
        //         title = 'Warning';
        //         icon = Icons.adjust;
        //         break;
        //       case NotificationType.reminder:
        //         color = Colors.amberAccent;
        //         title = 'Reminder';
        //         icon = Icons.error_outline_rounded;
        //         break;
        //       default:
        //         color = Colors.black;
        //         title = 'Null';
        //         icon = Icons.notifications_none;
        //     }
        //     return Padding(
        //       padding: const EdgeInsets.only(bottom: 8.0),
        //       child: ListTile(
        //         shape: RoundedRectangleBorder(
        //           side: BorderSide(color: color, width: 1),
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //         leading: Icon(
        //           icon,
        //           size: kDefaultIconSize,
        //           color: color,
        //         ),
        //         title: Text(
        //           title,
        //           style: TextStyle(
        //             color: color,
        //             fontSize: kTitlesFontSize,
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
