import 'package:app/services/firebase_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../model/user.dart';

class CvScreen extends StatelessWidget {
  const CvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get the data from the previous screen
    final UserData user =
        ModalRoute.of(context)?.settings.arguments as UserData;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          // dialog with three inputs and controller
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final TextEditingController skillController =
                  TextEditingController(text: user.skills?.join(', ') ?? '');
              final TextEditingController interestController =
                  TextEditingController(text: user.interests?.join(', ') ?? '');
              final TextEditingController natonalityController =
                  TextEditingController(text: user.natonality ?? '');
              return AlertDialog(
                title: Text('Update your CV'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: skillController,
                      decoration: InputDecoration(
                        labelText: 'Skill',
                        helperText: 'Add your skill, use comma to separate',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: interestController,
                      decoration: InputDecoration(
                        labelText: 'Interest',
                        helperText: 'Add your Interest, use comma to separate',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: natonalityController,
                      decoration: InputDecoration(
                        labelText: 'Natonality',
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Add'),
                    onPressed: () async {
                      // get the data from the inputs
                      final String skill = skillController.text;
                      final String interest = interestController.text;
                      final String natonality = natonalityController.text;
                      // convert skill to list
                      final List<String> skills = skill.split(',');
                      final List<String> interests = interest.split(',');
                      // add the skill to the list
                      // add cv to the user
                      final state = await FirebaseServices().addCv(
                        skills,
                        interests,
                        natonality,
                      );
                      if (state) {
                        Navigator.of(context).pop();
                      } else {
                        showTopSnackBar(
                            context, CustomSnackBar.error(message: 'Error'));
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.edit),
      ),
      body: Row(
        children: [
          Container(
            height: 1000,
            width: 170,
            color: Colors.teal,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(50),
                ),
                CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(
                      user.image ?? '',
                      maxHeight: 60,
                      maxWidth: 60,
                    )),
                const Padding(
                  padding: const EdgeInsets.all(10),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 19,
                  ),
                  title: Text('Name',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  subtitle: Text('${user.name}',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 19,
                  ),
                  title: Text('phone number',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  subtitle: const Text('0581XXXXX',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 19,
                  ),
                  title: Text('Email',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  subtitle: Text('${user.email}',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
                ListTile(
                  leading: Icon(
                    Icons.date_range,
                    color: Colors.white,
                    size: 19,
                  ),
                  title: Text('Date of Birth',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  subtitle: Text(user.dob.toString().split(' ')[0],
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
                ListTile(
                  leading: Icon(
                    Icons.nature_people_outlined,
                    color: Colors.white,
                    size: 19,
                  ),
                  title: Text('Nationality',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                  subtitle: Text(user.natonality ?? 'Unknown',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.filter_vintage,
                    color: Colors.white,
                    size: 19,
                  ),
                  title: Text('interests',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  subtitle: Text(user.interests?.join(',') ?? 'Unknown',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ],
            ),
          ),
          Container(
            height: 1000,
            width: 220,
            color: Colors.white,
            child: Column(children: [
              const Padding(
                padding: const EdgeInsets.all(30),
              ),
              const Padding(padding: const EdgeInsets.only(left: 30)),
              IconButton(
                  icon: const Icon(
                    Icons
                        .close, //Padding(padding:EdgeInsets.only(left: 80),//),
                    color: Colors.teal,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              const Padding(
                padding: const EdgeInsets.all(40),
              ),
              ListTile(
                leading: const Icon(
                  Icons.reduce_capacity_rounded,
                  color: Colors.teal,
                  size: 18,
                ),
                title: const Text('Educational Qualification',
                    style: TextStyle(color: Colors.teal, fontSize: 11)),
                subtitle: Text('${user.level}',
                    style: TextStyle(color: Colors.teal, fontSize: 10)),
              ),
              ListTile(
                leading: Icon(
                  Icons.verified_user_rounded,
                  color: Colors.teal,
                  size: 19,
                ),
                title: Text('skills',
                    style: TextStyle(color: Colors.teal, fontSize: 12)),
                subtitle: Text(user.skills?.join(',') ?? 'Unknown',
                    style: TextStyle(color: Colors.teal, fontSize: 10)),
              ),
              const ListTile(
                leading: const Icon(
                  Icons.menu_book_sharp,
                  color: Colors.teal,
                  size: 19,
                ),
                title: const Text(' Training courses',
                    style: TextStyle(color: Colors.teal, fontSize: 12)),
                subtitle: const Text('java,htmll,css,c++,dart,flutter',
                    style: TextStyle(color: Colors.teal, fontSize: 10)),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
