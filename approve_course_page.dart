import 'dart:io';

import 'package:app/services/firebase_services.dart';
import 'package:app/ui/widgets/course_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApproveCoursePage extends StatelessWidget {
  const ApproveCoursePage({Key? key, required this.clubId}) : super(key: key);
  final String clubId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/requestNewCourse', arguments: clubId);
        },
      ),
      appBar: AppBar(title: Text("Approve screen page")),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: FirebaseServices().getCoursesByClubIdAndState(clubId, 1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // chheck
            if (snapshot.hasError) {
              return Center(child: Text("Error"));
            }
            // check if empty
            if (snapshot.data!.isEmpty) {
              return Center(child: Text("No courses to approve"));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final course = snapshot.data![index];
                return CourseCard(
                    image: course.get('image'),
                    onPressed: () {
                      // bview course details and add course as parameter
                      Navigator.pushNamed(
                        context,
                        '/course_details',
                        arguments: course,
                      );
                    },
                    name: course.get('name'),
                    date: formatDate(parseTime(course.get('startDate'))));
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // firebase time stamp to date
  DateTime parseTime(dynamic date) {
    return Platform.isIOS ? (date as Timestamp).toDate() : (date as DateTime);
  }

  // format date to USA
  String formatDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }
}
