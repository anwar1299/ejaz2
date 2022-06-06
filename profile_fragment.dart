import 'package:app/model/user.dart';
import 'package:app/services/firebase_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/constants.dart';
import '../../../main.dart';
import '../option_listtile.dart';
import '../settings_sheet.dart';
import '../user_information.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: FirebaseServices().getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData user =
                    UserData.fromJson(snapshot.data as Map<String, dynamic>);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // check if user has profile picture
                    if (auth.currentUser?.photoURL != null)
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: kPrimaryColor,
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  auth.currentUser?.photoURL ?? ''),
                              radius: ScreenUtil().setHeight(45),
                            ),
                          ),
                        ),
                      ),
                    if (auth.currentUser?.photoURL == null)
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: kPrimaryColor,
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage:
                                  const AssetImage('assets/image/user.png'),
                              radius: ScreenUtil().setHeight(45),
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultHorizontalPadding * 0.25,
                            vertical: kDefaultVerticalPadding * 0.5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 1,
                                child: UserInformation(
                                  username: 'Name ${user.name}',
                                  phonenumber: 'Email ${user.email}',
                                  numberID: ' ID ${user.uid}',
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Divider(
                                        color: Colors.grey.withOpacity(0.5),
                                        height: 0.05,
                                      ),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            getOptions(user.role!).length,
                                        itemBuilder: (context, index) {
                                          return OptionListTile(
                                            icon: getOptions(user.role!)[index]
                                                ['icon'],
                                            title: getOptions(user.role!)[index]
                                                ['title'],
                                            onPressed: () {
                                              // Move to the selected page
                                              switch (index) {
                                                case 0:
                                                  Navigator.pushNamed(
                                                      context,
                                                      getOptions(user.role!)[
                                                          index]['route'],
                                                      arguments: user);
                                                  break;

                                                case 1:
                                                  if (user.role ==
                                                      'presenter') {
                                                    // show bottom sheet with options
                                                    _showPresenterSheet(
                                                        context);
                                                  } else if (user.role ==
                                                      'supervisor') {
                                                    Navigator.pushNamed(
                                                        context,
                                                        getOptions(user.role!)[
                                                            index]['route'],
                                                        arguments: user);
                                                    break;
                                                  } else {
                                                    Navigator.pushNamed(
                                                        context,
                                                        getOptions(user.role!)[
                                                            index]['route']);
                                                  }

                                                  break;

                                                  break;
                                                case 2:
                                                  _showSettingsSheet(context);
                                                  // Implement Logout functionality
                                                  break;
                                                case 3:
                                                  auth.signOut().then((value) {
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            '/login',
                                                            (route) => false);
                                                  });

                                                  break;
                                                case 4:
                                                  if (user.role ==
                                                      'presenter') {
                                                    // show bottom sheet with options
                                                    // go to cv page
                                                    Navigator.pushNamed(
                                                        context,
                                                        getOptions(user.role!)[
                                                            index]['route'],
                                                        arguments: user);
                                                  } else if (user.role ==
                                                      'supervisor') {
                                                    Navigator.pushNamed(
                                                        context,
                                                        getOptions(user.role!)[
                                                            index]['route'],
                                                        arguments: user);
                                                    break;
                                                  } else {
                                                    Navigator.pushNamed(
                                                        context,
                                                        getOptions(user.role!)[
                                                            index]['route']);
                                                  }
                                                  // Navigator.pushNamed(
                                                  //     context, '/addLocation');
                                                  break;
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  void _showPresenterSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: Colors.teal,
        builder: (BuildContext context) {
          return SizedBox(
            height: 400,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Request a course',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/requestNewCourse');
                  },
                ),
                ListTile(
                  title: Text(
                    'Request Status',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/order_status');
                  },
                ),
                ListTile(
                  title: Text(
                    'My Courses',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/presenter_my_courses_page');
                  },
                ),
                ListTile(
                  title: Text(
                    'Training Courses',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/courses');
                  },
                ),
              ],
            ),
          );
        });
  }
}

List getOptions(String role) {
  if (role == 'manager') {
    return managerOptions;
  } else if (role == 'supervisor') {
    return supervisorOptions;
  } else if (role == 'presenter') {
    return presenterOptions;
  } else {
    return profileOptions;
  }
}

void _showSettingsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: kPrimaryColor,
    elevation: 1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    builder: (BuildContext context) {
      return SettingsSheet(
        onOptionPressed: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/notifications');
              break;
          }
        },
      );
    },
  );
}
