import 'package:app/services/firebase_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import 'cv_screen.dart';

class SupervisorClupScreen extends StatelessWidget {
  const SupervisorClupScreen({Key? key, required this.supervisorId})
      : super(key: key);
  final String supervisorId;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.teal,
        body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseServices().getUserData(supervisorId),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                final user = UserData.fromJson(
                    snapshot.data?.data() as Map<String, dynamic>);
                return Column(children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 60),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 280),
                    child: IconButton(
                        icon: const Icon(
                          Icons
                              .arrow_circle_right_outlined, //Padding(padding:EdgeInsets.only(left: 80),//),
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          // final route = MaterialPageRoute(
                          //     builder: (context) => ClubProfilePage());
                          // Navigator.push(context, route);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Expanded(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage:
                          CachedNetworkImageProvider(user.image ?? ''),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Text('${user.name}',
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                  Row(children: [
                    Spacer(),
                    Text('${user.email}',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    width: 400,
                    height: 400,
                    color: Colors.white,
                    child: Column(children: [
                      Card(
                        margin: EdgeInsets.all(40),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.teal, width: 2)),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                color: Colors.teal,
                                padding: EdgeInsets.all(10),
                                child:
                                    FutureBuilder<List<QueryDocumentSnapshot>>(
                                        future: FirebaseServices()
                                            .getSupervisorClub(supervisorId),
                                        builder: (context,
                                            AsyncSnapshot<
                                                    List<QueryDocumentSnapshot>>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            final clubs = snapshot.data;
                                            return Text('${clubs?.length}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20));
                                          } else {
                                            return Text('Loading...',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20));
                                          }
                                        }),
                              ),
                              Expanded(
                                child: Text('Clubs',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(40),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.teal, width: 2)),
                        child: InkWell(
                          onTap: () {
                            final route = MaterialPageRoute(
                                builder: (context) => CvScreen());
                            Navigator.push(context, route);
                            // push name
                            Navigator.pushNamed(context, '/cv',
                                arguments: user);
                          },
                          child: Row(
                            children: [
                              Container(
                                color: Colors.teal,
                                padding: EdgeInsets.all(10),
                                child: Text('CV',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                              ),
                              Expanded(
                                child: Text('${user.name}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  )
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
