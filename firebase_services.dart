import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'auth_exceptionHandler.dart';

class FirebaseServices {
  // collections
  CollectionReference users = fireStore.collection('users');

  // collection for the courses
  CollectionReference courses = fireStore.collection('courses');

  // create collection for clubs
  CollectionReference clubs = fireStore.collection('clubs');

  // create collection for locations
  CollectionReference locations = fireStore.collection('locations');

  // create collection for locations
  CollectionReference ratings = fireStore.collection('ratings');
  late AuthResultStatus _status;

  Future<AuthResultStatus> register(Map<String, dynamic>? userData) async {
    // copy map
    final userProfile = Map<String, dynamic>.from(userData!);

    try {
      var role = 'supervisor';
      var isActive = false;

      // check if email contain @st.uqu.edu.sa
      if (userData['email'].contains('@st.uqu.edu.sa')) {
        role = 'student';
        isActive = true;
      } else if (userData['email'].contains('@uqu.edu.sa')) {
        role = 'presenter';
        isActive = true;
      }
      // update role in userData
      userProfile['role'] = role;
      userProfile['isActive'] = isActive;
      _status = await addUser(userProfile);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> addUser(Map<String, dynamic> userProfile) async {
    try {
      final User? user = (await auth.createUserWithEmailAndPassword(
        email: userProfile['email'],
        password: userProfile['password'],
      ))
          .user;
      if (user != null) {
        await user.updateDisplayName(userProfile['name']);

        users.doc(user.uid).set(userProfile
          ..remove('password')
          ..remove('password_confirmation'));
        _status = AuthResultStatus.successful;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }

  Future<AuthResultStatus> login(Map<String, dynamic>? userData) async {
    try {
      final User? user = (await auth.signInWithEmailAndPassword(
        email: userData!['email'],
        password: userData['password'],
      ))
          .user;
      if (user != null) {
        _status = AuthResultStatus.successful;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<DocumentSnapshot> getUserData(String? uid) async {
    return await users.doc(uid).get();
  }

  Future getUser() async {
    return (await getUserData(auth.currentUser?.uid)).data();
  }

  addNewClub(Map<String, dynamic>? clubData) async {
    try {
      final club = Map<String, dynamic>.from(clubData!);
      clubs.add(club..remove('image')).then((value) {
        saveImages(File(clubData['image'][0].path), value);
      });

      // saveImages(clubData['image'][0], inClub);
      _status = AuthResultStatus.successful;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
    }
    return _status;
  }

  //query for supervisor
  Future<List<QueryDocumentSnapshot>> getSupervisor() async {
    try {
      final supervisor =
          await users.where('role', isEqualTo: 'supervisor').get();
      return supervisor.docs;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot>> getMyClubs() async {
    try {
      final myClubs = await clubs
          .where('supervisor', isEqualTo: auth.currentUser?.uid)
          .get();
      return myClubs.docs;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return [];
    }
  }

  // Save Image
  Future<String?> saveImages(File _images, DocumentReference ref) async {
    print('ame ${_images.runtimeType}');
    String? imageURL = await uploadFile(_images);
    ref.update({"image": (imageURL)});
    return imageURL;
  }

  Future<String?> uploadFile(File _image) async {
    TaskSnapshot uploadTask = await FirebaseStorage.instance
        .ref()
        .child('images/${getFileName(_image.path)}')
        .putFile(_image);

    String pathdownlaod = await uploadTask.ref.getDownloadURL();

    return pathdownlaod;
  }

  // get file name from file path
  String getFileName(String path) {
    return path.split('/').last;
  }

  Future<List<QueryDocumentSnapshot>> getSupervisorClub(
      String supervisorId) async {
    try {
      return clubs
          .where('supervisor', isEqualTo: supervisorId)
          .get()
          .then((value) => value.docs);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return [];
    }
  }

  void updateClubName(QueryDocumentSnapshot club, text) {
    try {
      club.reference.update({"name": text});
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
    }
  }

  void updateClubImage(String path, QueryDocumentSnapshot club) {
    try {
      saveImages(File(path), club.reference);
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
    }
  }

  Future<List<QueryDocumentSnapshot>> getClubs() async {
    try {
      return clubs.get().then((value) => value.docs);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot>> getLocations() async {
    try {
      return locations.get().then((value) => value.docs);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return [];
    }
  }

  addNewCourse(Map<String, dynamic>? dataForm) async {
    try {
      final courseAdd = Map<String, dynamic>.from(dataForm!);
      // add state to courseAdd
      courseAdd['state'] = 1;
      // add id for user
      courseAdd['userId'] = auth.currentUser?.uid;
      // start date
      courseAdd['startDate'] = (courseAdd['date_range'] as DateTimeRange).start;
      // end date
      courseAdd['endDate'] = (courseAdd['date_range'] as DateTimeRange).end;
      courses
          .add(courseAdd
            ..remove('image')
            ..remove('date_range'))
          .then((value) {
        saveImages(File(dataForm['image'][0].path), value);
      });

      // saveImages(clubData['image'][0], inClub);
      _status = AuthResultStatus.successful;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
    }
    return _status;
  }

  Future<List<QueryDocumentSnapshot>> getCourses() async {
    try {
      return courses.get().then((value) => value.docs);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return [];
    }
  }

  // get supervisor by club id
  Future<DocumentSnapshot?> getSupervisorByClubId(String clubId) async {
    try {
      DocumentSnapshot id = await clubs.doc(clubId).get();
      return getUserData(id.get('supervisor'));
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return null;
    }
  }

  // get course by user id
  Future<List<QueryDocumentSnapshot>> getCoursesByUserId(String userId) async {
    try {
      return courses
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) => value.docs);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return [];
    }
  }

  // get course by club id
  Future<List<QueryDocumentSnapshot>> getCoursesByClubId(String clubId) async {
    try {
      return courses
          .where('club', isEqualTo: clubId)
          .get()
          .then((value) => value.docs);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return [];
    }
  }

  // get course by course id
  Future<DocumentSnapshot?> getCourseByCourseId(String courseId) async {
    try {
      return courses.doc(courseId).get();
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot>> getReviewCourses() async {
    try {
      // get club supervisor
      var myClubs = await clubs
          .where('supervisor', isEqualTo: auth.currentUser?.uid)
          .get();
      List ids = myClubs.docs.map((e) {
        return e.id;
      }).toList();
      print('$ids');
      return courses
          .where('club', whereIn: ids)
          .get()
          .then((value) => value.docs);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
      return [];
    }
  }

  // get course by club id and state
  Future<List<QueryDocumentSnapshot>> getCoursesByClubIdAndState(
      String clubId, int state) async {
    try {
      return courses
          .where('club', isEqualTo: clubId)
          .where('state', isEqualTo: state)
          .get()
          .then((value) => value.docs);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return [];
    }
  }

  // get course by state
  Stream<QuerySnapshot<Object?>>? getCoursesByState(int state) {
    try {
      return courses
          .where('state', isEqualTo: state)
          .where('startDate', isGreaterThanOrEqualTo: DateTime.now())
          .snapshots();
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
      return null;
    }
  }

  Future<bool> joinCourse(QueryDocumentSnapshot? courseName) async {
    final userObj = await getUserData(auth.currentUser?.uid);
    try {
      await courseName?.reference.update({
        'subscribers': FieldValue.arrayUnion([userObj.data()])
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> leaveCourse(QueryDocumentSnapshot? courseName) async {
    final userObj = await getUserData(auth.currentUser?.uid);
    try {
      await courseName?.reference.update({
        'subscribers': FieldValue.arrayRemove([userObj.data()])
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  // check if user is subscribed to course
  Future<bool> isSubscribed(QueryDocumentSnapshot? courseName) async {
    final userObj = await getUserData(auth.currentUser?.uid);
    try {
      // is subscribers is exist and contain current user
      if ((courseName?.data() as Map<String, dynamic>)
          .containsKey('subscribers')) {
        List subscribers = courseName!['subscribers'] ?? [];

        var firstWhere = subscribers.firstWhere(
            (e) => e['email'] == userObj.get('email'),
            orElse: () => null);

        return firstWhere != null;
      } else {
        return false;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
      return false;
    }
  }

  getMyCourses() {
    return getMyCoursesSubscribed();
  }

  Future<List<QueryDocumentSnapshot>> getMyCoursesSubscribed() async {
    // get my courses I subscribed to
    final userObj = await getUserData(auth.currentUser?.uid);
    return courses
        .where('subscribers', arrayContains: userObj.data())
        .where('state', isEqualTo: 4)
        //   .where('startDate', isLessThan: DateTime.now())
        .get()
        .then((value) => value.docs);
  }

  Future<List<QueryDocumentSnapshot>> getMyCoursesIPresented() async {
    // get my courses I subscribed to
    return courses
        .where('userId', arrayContains: auth.currentUser?.uid)
        .where('state', isEqualTo: 4)

        //   .where('startDate', isLessThan: DateTime.now())
        .get()
        .then((value) => value.docs);
  }

  Future<List<QueryDocumentSnapshot>> getPreviousCourses() async {
    // get my courses I created
    final userObj = await getUserData(auth.currentUser?.uid);
    return courses
        .where('subscribers', arrayContains: userObj.data())
        .where('state', isEqualTo: 4)
        // .where('startDate', isGreaterThan: DateTime.now())
        //  .where('endDate', isGreaterThan: DateTime.now())
        .get()
        .then((value) => value.docs);
  }

  // save rating to course
  Future<bool> saveRating(
      QueryDocumentSnapshot? courseName, double rating) async {
    final userObj = await getUserData(auth.currentUser?.uid);
    try {
      await courseName?.reference.update({
        'rating': FieldValue.arrayUnion([rating])
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  // save rating to ratings collection with user id and course id
  Future<bool> saveRatingToRatings(
      QueryDocumentSnapshot? courseName, List rating) async {
    final userObj = await getUserData(auth.currentUser?.uid);
    try {
      await ratings.add({
        'userId': userObj.id,
        'courseId': courseName?.id,
        'rating': FieldValue.arrayUnion(rating)
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  // check if user and course is exist in ratings collection
  Future<bool> isRated(QueryDocumentSnapshot? courseName) async {
    final userObj = await getUserData(auth.currentUser?.uid);
    try {
      // is subscribers is exist and contain current user
      final ratings = await this
          .ratings
          .where('userId', isEqualTo: userObj.id)
          .where('courseId', isEqualTo: courseName?.id)
          .get();
      if (ratings.docs.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
      return false;
    }
  }

  // subscribe to  a club, check if user is exist in subscribers collection
  Future<bool> subscribe(QueryDocumentSnapshot club) async {
    final userObj = await getUserData(auth.currentUser?.uid);
    try {
      // is subscribers is exist and contain current user
      final subscribers = await club.reference
          .collection('subscribers')
          .where('userId', isEqualTo: userObj.id)
          .get();
      if (subscribers.docs.isNotEmpty) {
        return true;
      } else {
        await club.reference.collection('subscribers').add({
          'userId': userObj.id,
        });
        return false;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
      return false;
    }
  }

  // check if is subscribed to club
  Future<bool> isSubscribedToClub(QueryDocumentSnapshot club) async {
    final userObj = await getUserData(auth.currentUser?.uid);
    try {
      // is subscribers is exist and contain current user
      final subscribers = await club.reference
          .collection('subscribers')
          .where('userId', isEqualTo: userObj.id)
          .get();
      if (subscribers.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
      return false;
    }
  }

  // leave a club
  Future<bool> unsubscribe(QueryDocumentSnapshot club) async {
    final userObj = await getUserData(auth.currentUser?.uid);
    try {
      // is subscribers is exist and contain current user
      final subscribers = await club.reference
          .collection('subscribers')
          .where('userId', isEqualTo: userObj.id)
          .get();
      if (subscribers.docs.isNotEmpty) {
        await club.reference
            .collection('subscribers')
            .doc(subscribers.docs[0].id)
            .delete();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print(e);
      return false;
    }
  }

  Future<bool> addCv(
      List<String> skills, List<String> interests, String natonality) async {
    final DocumentSnapshot userObj = await getUserData(auth.currentUser?.uid);
    try {
      // remove old skills and interests
      await userObj.reference.update({
        'skills': FieldValue.delete(),
        'interests': FieldValue.delete(),
      });
      await userObj.reference.update({
        'skills': FieldValue.arrayUnion(skills),
        'interests': FieldValue.arrayUnion(interests),
        'natonality': natonality,
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> updateUserImage(String path) async {
    final DocumentSnapshot userObj = await getUserData(auth.currentUser?.uid);
    try {
      final img = await saveImages(File(path), userObj.reference);
      auth.currentUser?.updatePhotoURL(img);
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> updateUserEmail(String text) async {
    final DocumentSnapshot userObj = await getUserData(auth.currentUser?.uid);
    try {
      auth.currentUser?.updateEmail(text);
      await userObj.reference.update({
        'email': text,
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> updateUserName(String text) async {
    final DocumentSnapshot userObj = await getUserData(auth.currentUser?.uid);
    try {
      await userObj.reference.update({
        'name': text,
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> updateUserBio(String text) async {
    final DocumentSnapshot userObj = await getUserData(auth.currentUser?.uid);
    try {
      await userObj.reference.update({
        'bio': text,
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> updateUserPhone(String text) async {
    final DocumentSnapshot userObj = await getUserData(auth.currentUser?.uid);
    try {
      await userObj.reference.update({
        'phone': text,
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<QuerySnapshot> searchCourses(String query) async {
    // search in courses
    return await courses.where('name', isEqualTo: query).get();
  }

  Future<DocumentSnapshot> getLocationById(DocumentReference location) async {
    return await location.get();
  }

// create a new location in the database
  Future<bool> createLocation(String name) async {
    try {
      final DocumentReference location = await locations.add({
        'name': name,
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> updateLocation(DocumentReference location, String name) async {
    try {
      await location.update({
        'name': name,
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> deleteLocation(DocumentReference location) async {
    try {
      await location.delete();
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> acceptSupervisor(QueryDocumentSnapshot? club) async {
    try {
      club?.reference.update({
        'isActive': true,
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> deleteSupervisor(QueryDocumentSnapshot? club) async {
    try {
      club?.reference.delete();
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> addLocation(String text) async {
    try {
      final DocumentReference location = await locations.add({
        'name': text,
      });
      return true;
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  Future<bool> isAdmin() async {
    try {
      final DocumentSnapshot userObj = await getUserData(auth.currentUser?.uid);
      if (userObj.get('role') == 'manager') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return false;
    }
  }

  // Future<bool> updateUserGender(String text) async {
  //   auth.currentUser!.updateEmail(text);
  //   final DocumentSnapshot userObj = await getUserData(auth.currentUser?.uid);
  //   try {
  //     await userObj.reference.update({
  //       'email': text,
  //     });
  //     return true;
  //   } catch (e) {
  //     _status = AuthExceptionHandler.handleException(e);
  //     return false;
  //   }
  // }

// return image url from usres using where email

}
